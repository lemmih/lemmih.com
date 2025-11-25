#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_ROOT="$ROOT/.wrangler"
ASSETS_DIR="$ROOT/assets"
CLIENT_OUT="$ASSETS_DIR/pkg"

mkdir -p "$INSTALL_ROOT"
mkdir -p "$ASSETS_DIR"

if [ ! -x "$INSTALL_ROOT/bin/worker-build" ]; then
  echo "Installing worker-build into $INSTALL_ROOT" >&2
  cargo install worker-build --locked --root "$INSTALL_ROOT"
fi

if [ ! -x "$INSTALL_ROOT/bin/wasm-pack" ]; then
  echo "Installing wasm-pack into $INSTALL_ROOT" >&2
  cargo install wasm-pack --locked --root "$INSTALL_ROOT"
fi

export PATH="$INSTALL_ROOT/bin:$PATH"

# Build the client-side WASM bundle used for hydration.
TMP_CLIENT_OUT="$(mktemp -d "$ASSETS_DIR/pkg-build.XXXXXX")"
pushd "$ROOT/crates/client" >/dev/null
wasm-pack build \
  --target web \
  --out-dir "$TMP_CLIENT_OUT" \
  --out-name client \
  --release
popd >/dev/null
mkdir -p "$CLIENT_OUT"
rsync -a --delete "$TMP_CLIENT_OUT"/ "$CLIENT_OUT"/
rm -rf "$TMP_CLIENT_OUT"

# Build the server-side worker (SSR).
pushd "$ROOT/crates/worker" >/dev/null
worker-build --release
popd >/dev/null

# Prepare the worker entrypoint after worker-build has emitted the WASM artifacts.
WORKER_OUT="$ROOT/crates/worker/build/worker"
mkdir -p "$WORKER_OUT"
sed \
  -e 's|\./index.js|../index.js|g' \
  -e 's|\./index_bg.wasm|../index_bg.wasm|g' \
  "$ROOT/nix/worker-entrypoint.js" > "$WORKER_OUT/worker.js"
