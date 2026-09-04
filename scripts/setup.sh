#!/bin/bash
set -e

# Ask for the administrator password upfront
sudo -v

dotfiles="$(cd "$(dirname "$0")/.." && pwd)"

echo "Silencing terminal login messages"
touch ~/.hushlogin

echo "Creating workspace folder"
mkdir -p ~/workspace/

if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo "Finish installing the Xcode command line tools, then run setup again." >&2
  exit 1
fi

cd "$dotfiles"
./scripts/brew.sh

# Child processes cannot update this shell's environment.
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.bin:$PATH"

echo "Installing Neovim nightly"
./scripts/install-nvim-nightly.sh

# Change default shell to Homebrew zsh
echo "Changing default shell to Homebrew zsh"
brew_zsh="$(brew --prefix)/bin/zsh"
if ! grep -Fxq "$brew_zsh" /etc/shells; then
  echo "$brew_zsh" | sudo tee -a /etc/shells >/dev/null
fi
chsh -s "$brew_zsh"

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
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Global npm packages
echo "Installing global npm packages"
"$dotfiles/npm/install.sh"

echo "Installing codelldb"
"$dotfiles/scripts/install-codelldb.sh"

echo "Open a tmux session and do PREFIX + I to install plugins. Press enter to continue..."
read -r

echo "Install Ghostty https://github.com/ghostty-org/ghostty/releases/tag/tip Press enter to continue..."
read -r

echo "Install fonts. Press enter to continue..."
read -r

echo "Set wallpaper to black and screensaver to ~/dotfiles/wallpaper/. Press enter to continue..."
read -r

echo "Setup complete, log out and in again :)"
