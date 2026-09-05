#!/bin/bash
set -euo pipefail

dotfiles="$(cd "$(dirname "$0")/.." && pwd)"

case "$(uname -s):$(uname -m)" in
  Darwin:arm64) ;;
  *) echo "Setup supports Apple Silicon macOS." >&2; exit 1 ;;
esac

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
  echo "Finish installing the Xcode command line tools, then run setup again." >&2
  exit 1
fi
xcrun --find clang >/dev/null

cd "$dotfiles"
./scripts/brew.sh

# Child processes cannot update this shell's environment.
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.bin:${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

echo "Installing asdf Node and global npm packages"
"$dotfiles/npm/install.sh"

echo "Installing Neovim nightly"
./scripts/install-nvim-nightly.sh

echo "Installing codelldb"
"$dotfiles/scripts/install-codelldb.sh"

echo "Creating shell and workspace files"
touch ~/.hushlogin
mkdir -p ~/workspace/

# Symlinks
echo "Setting up symlinks"
link_config() {
  local source_path="$1" destination="$2" backup=""
  mkdir -p "$(dirname "$destination")" || return
  if [ -L "$destination" ] && [ "$(readlink "$destination")" = "$source_path" ]; then
    return
  fi
  if [ -e "$destination" ] || [ -L "$destination" ]; then
    backup="$(mktemp -d "$destination.backup.XXXXXX")" || return
    mv "$destination" "$backup/original" || return
    echo "Saved $destination to $backup/original"
  fi
  if ! ln -s "$source_path" "$destination"; then
    if [ -n "$backup" ]; then
      mv "$backup/original" "$destination"
    fi
    return 1
  fi
}

# ~/.config/ items
for dir in "$dotfiles"/.config/*/; do
  name="$(basename "$dir")"
  link_config "$dotfiles/.config/$name" "$HOME/.config/$name"
done

# ~/ dot files
link_config "$dotfiles/zsh/.zshrc" "$HOME/.zshrc"
link_config "$dotfiles/zsh/.zshenv" "$HOME/.zshenv"
link_config "$dotfiles/git/.gitconfig" "$HOME/.gitconfig"
link_config "$dotfiles/git/.gitignore_global" "$HOME/.gitignore_global"
link_config "$dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_config "$dotfiles/ideavim/.ideavimrc" "$HOME/.ideavimrc"
link_config "$dotfiles/pi" "$HOME/.pi/agent"
link_config "$dotfiles/.config/hammerspoon/init.lua" "$HOME/.hammerspoon/init.lua"
link_config "$dotfiles/keybindings/Library/KeyBindings/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
for file in "$dotfiles/vscode/Library/Application Support/Code/User"/*; do
  [ -f "$file" ] || continue
  link_config "$file" "$HOME/Library/Application Support/Code/User/$(basename "$file")"
done

theme_link="$dotfiles/.config/ghostty/themes/current-theme"
if [ ! -e "$theme_link" ] && [ ! -L "$theme_link" ]; then
  ln -s custom/unsure "$theme_link"
fi

# tmux plugins
if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "Installing tmux plugins"
  git -c 'url.https://github.com/tmux-plugins/tpm.insteadOf=https://github.com/tmux-plugins/tpm' \
    clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Activate the new login shell only after its tools and configuration are ready.
echo "Changing default shell to Homebrew zsh"
brew_zsh="$(brew --prefix)/bin/zsh"
test -x "$brew_zsh"
if ! grep -Fxq "$brew_zsh" /etc/shells; then
  echo "$brew_zsh" | sudo tee -a /etc/shells >/dev/null
fi
chsh -s "$brew_zsh"

echo "Core setup complete. Open a new login shell."
echo "Optional GUI applications: $dotfiles/scripts/brew.sh --apps"
echo "Install Ghostty tip and fonts, then use tmux PREFIX + I to install plugins."
echo "Desktop preferences remain separate: $dotfiles/scripts/preferences.sh"
