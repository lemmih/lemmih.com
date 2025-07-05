{
  description = "CV website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    cv.url = "path:../cv";
    wrangler.url = "github:emrldnix/wrangler";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    cv,
    wrangler,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      wrangler-bin = wrangler.packages.${system}.default;

      static-site = pkgs.stdenv.mkDerivation {
        name = "cv-lemmih-com";
        # Don't use src at all since we're just copying files directly
        src = null;

        buildInputs = [
          cv.packages.${system}.cv
        ];

        # Skip phases we don't need
        dontUnpack = true;
        dontBuild = true;

        installPhase = ''
          mkdir -p $out
          # Copy the CV PDF from the cv flake
          cp ${cv.packages.${system}.cv}/cv.pdf $out/
          # Copy the _redirects file directly from the source
          cp ${./_redirects} $out/_redirects
        '';
      };
    in {
      packages.default = static-site;

      apps.deploy = {
        type = "app";
        program = let
          script = pkgs.writeScriptBin "deploy" ''
            #!${pkgs.bash}/bin/bash
            set -euo pipefail

            # Create temporary work directory
            workdir=$(mktemp -d)
            trap "rm -rf $workdir" EXIT

            echo "Created temporary work directory: $workdir"

            # Copy wrangler.jsonc to work directory
            cp ${./wrangler.jsonc} "$workdir/wrangler.jsonc"

            # Link static-site to results in work directory
            ln -sf ${static-site} "$workdir/result"

            echo "Deploying to Cloudflare Pages..."

            # Run wrangler deploy from work directory
            cd "$workdir"
            ${wrangler-bin}/bin/wrangler deploy --env prebuilt "$@"
          '';
        in "${script}/bin/deploy";
        meta.description = "Deploy the static site to Cloudflare Pages";
      };
    });
}
