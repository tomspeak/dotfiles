#!/bin/bash
set -euo pipefail

dotfiles="$(cd "$(dirname "$0")/.." && pwd)"
case "${1:-}" in
  '') brewfile="$dotfiles/Brewfile" ;;
  --apps) brewfile="$dotfiles/Brewfile.apps" ;;
  *) echo "Usage: $0 [--apps]" >&2; exit 1 ;;
esac

# Install Homebrew if not present
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available in this shell (Apple Silicon path)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Keep optional GUI applications independent of the core toolchain.
echo "Installing dependencies from $brewfile"
brew bundle --file="$brewfile"
