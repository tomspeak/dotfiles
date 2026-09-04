#!/bin/bash

set -euo pipefail

install_dir="$HOME/.local/share/codelldb"
mkdir -p "$(dirname "$install_dir")"
stage="$(mktemp -d "${install_dir}.install.XXXXXX")"
published=false
cleanup() {
  if [ "$published" = false ] && { [ -e "$stage/previous" ] || [ -L "$stage/previous" ]; }; then
    if [ -e "$install_dir" ] || [ -L "$install_dir" ]; then
      mv "$install_dir" "$stage/failed" || return 1
    fi
    if ! mv "$stage/previous" "$install_dir"; then
      echo "Previous CodeLLDB installation remains at $stage/previous" >&2
      return 1
    fi
  fi
  rm -rf -- "$stage"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

curl -fL --output "$stage/codelldb.vsix" \
  https://github.com/vadimcn/codelldb/releases/download/v1.11.5/codelldb-darwin-arm64.vsix
unzip -q "$stage/codelldb.vsix" -d "$stage/new"

adapter="$stage/new/extension/adapter/codelldb"
test -f "$adapter"
test -d "$stage/new/extension/lldb/lib"
chmod +x "$adapter"

# Preserve the previous adapter until the complete replacement is ready.
if [ -e "$install_dir" ] || [ -L "$install_dir" ]; then
  mv "$install_dir" "$stage/previous"
fi
mv "$stage/new" "$install_dir"
published=true

echo "CodeLLDB installed to $install_dir"
