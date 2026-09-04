#!/bin/bash
set -euo pipefail

dotfiles="$(cd "$(dirname "$0")/.." && pwd)"
cd "$dotfiles"

node_version="$(awk '$1 == "nodejs" { print $2 }' .tool-versions)"
if [[ ! "$node_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Expected one exact Node version in $dotfiles/.tool-versions" >&2
  exit 1
fi
export ASDF_NODEJS_VERSION="$node_version"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Public runtime downloads must not inherit the personal GitHub SSH rewrite.
plugins="$(asdf plugin list)"
if ! grep -Fxq nodejs <<<"$plugins"; then
  GIT_CONFIG_GLOBAL=/dev/null asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi
# Install packages explicitly below for both new and already-installed versions.
GIT_CONFIG_GLOBAL=/dev/null ASDF_NPM_DEFAULT_PACKAGES_FILE=/dev/null asdf install nodejs "$node_version"

asdf exec node --version
asdf exec npm --version
xargs asdf exec npm install -g <"$dotfiles/npm/global-packages.txt"
asdf reshim nodejs "$node_version"
asdf set --home nodejs "$node_version"
