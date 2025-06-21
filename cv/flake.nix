{
  description = "CV generation with Typst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = {
          # Pre-download Typst dependencies and generate package cache
          typst-cache = pkgs.stdenvNoCC.mkDerivation {
            pname = "typst-cache";
            version = "1.0.0";

            src = ./.;

            nativeBuildInputs = with pkgs; [
              typst
            ];

            buildPhase = ''
              # Create a temporary directory for the cache
              export TYPST_PACKAGE_CACHE_PATH="$TMPDIR/typst-cache"
              mkdir -p "$TYPST_PACKAGE_CACHE_PATH"

              # Compile to trigger dependency download
              typst compile cv.typ cv.pdf --ignore-system-fonts --font-path fonts

              # Copy the cache to our output
              cp -r "$TYPST_PACKAGE_CACHE_PATH" $out
            '';

            outputHashMode = "recursive";
            outputHash = "sha256-Nohj29dvmzem8NmewTAzUpKY/DBCEkEfG6gM5D2G4Lo==";
            outputHashAlgo = "sha256";

            meta = with pkgs.lib; {
              description = "Typst package cache with dependencies";
              platforms = platforms.all;
            };
          };

          cv = pkgs.stdenvNoCC.mkDerivation {
            pname = "cv";
            version = "1.0.0";

            src = ./.;

            nativeBuildInputs = with pkgs; [
              typst
            ];

            buildInputs = [
              self.packages.${system}.typst-cache
            ];

            buildPhase = ''
              # Set up the Typst cache from our pre-downloaded dependencies
              export TYPST_PACKAGE_CACHE_PATH="${self.packages.${system}.typst-cache}"

              typst compile cv.typ cv.pdf --ignore-system-fonts --font-path fonts
            '';

            installPhase = ''
              mkdir -p $out
              cp cv.pdf $out/
            '';

            meta = with pkgs.lib; {
              description = "CV generated with Typst";
              platforms = platforms.all;
            };
          };

          default = self.packages.${system}.cv;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            typst
          ];

          shellHook = ''
            echo "Typst development environment loaded."
            echo "Run 'typst compile cv.typ cv.pdf --ignore-system-fonts --font-path fonts' to build the CV."
          '';
        };

        apps = {
          build-cv = utils.lib.mkApp {
            drv = self.packages.${system}.cv;
          };

          default = self.apps.${system}.build-cv;
        };
      }
    );
}
