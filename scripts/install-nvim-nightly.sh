#!/bin/bash
set -euo pipefail

install_root="$HOME/.nvim-nightly"
launcher="$HOME/.bin/nvim"

if [ -e "$launcher" ] && [ ! -L "$launcher" ]; then
  echo "Refusing to replace an existing file or directory: $launcher" >&2
  exit 1
fi

mkdir -p "$install_root" "$HOME/.bin"
build="$(mktemp -d "$install_root/build.XXXXXX")"
published=false
cleanup() {
  if [ "$published" = false ]; then
    rm -rf -- "$build"
  fi
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

curl -fL --output "$build/archive.tar.gz" \
  https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
tar -xzf "$build/archive.tar.gz" -C "$build" --strip-components=1
rm "$build/archive.tar.gz"
test -f "$build/share/nvim/runtime/doc/help.txt"
"$build/bin/nvim" --version >/dev/null

# Publish only a verified build, replacing the launcher with one rename.
previous="$(readlink "$launcher" || true)"
ln -s "$build/bin/nvim" "$build/launcher"
mv -fh "$build/launcher" "$launcher"
published=true

# Only remove installations created by this updater or its predecessor.
case "$previous" in
  "$install_root"/build.??????/bin/nvim|"$install_root/nvim-nightly/bin/nvim")
    rm -rf -- "${previous%/bin/nvim}"
    ;;
esac

echo "Installed Neovim nightly -> $launcher"
