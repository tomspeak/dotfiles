#!/bin/bash
set -e

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

# Install everything from the Brewfile
echo "Running brew bundle"
brew bundle --file="$(cd "$(dirname "$0")/.." && pwd)/Brewfile"
