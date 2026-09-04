#!/bin/bash
set -euo pipefail

install_root="$HOME/.nvim-nightly"
launcher="$HOME/.bin/nvim"
rollback_link="$install_root/previous"

if [ -e "$launcher" ] && [ ! -L "$launcher" ]; then
  echo "Refusing to replace an existing file or directory: $launcher" >&2
  exit 1
fi
if [ -e "$rollback_link" ] && [ ! -L "$rollback_link" ]; then
  echo "Refusing to replace an existing rollback directory: $rollback_link" >&2
  exit 1
fi

mkdir -p "$install_root" "$HOME/.bin"
build="$(mktemp -d "$install_root/build.XXXXXX")"
cleanup() {
  if [ "$(readlink "$launcher" || true)" != "$build/bin/nvim" ]; then
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
older="$(readlink "$rollback_link" || true)"
ln -s "$build/bin/nvim" "$build/launcher"
mv -fh "$build/launcher" "$launcher"

# Keep one previous runtime for rollback and already-running Neovim sessions.
case "$previous" in
  "$install_root"/build.??????/bin/nvim|"$install_root/nvim-nightly/bin/nvim")
    ln -s "${previous%/bin/nvim}" "$build/previous"
    mv -fh "$build/previous" "$rollback_link"
    case "$older" in
      "$install_root"/build.??????|"$install_root/nvim-nightly")
        if [ "$older" != "${previous%/bin/nvim}" ] && [ "$older" != "$build" ]; then
          rm -rf -- "$older"
        fi
        ;;
    esac
    ;;
esac

echo "Installed Neovim nightly -> $launcher"
