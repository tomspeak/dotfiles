#!/bin/bash
set -e

# Ask for the administrator password upfront
sudo -v

dotfiles="$(cd "$(dirname "$0")/.." && pwd)"

echo "Silencing terminal login messages"
touch ~/.hushlogin

echo "Creating workspace folder"
mkdir -p ~/workspace/

echo "Installing Xcode CLI tools"
xcode-select --install 2>/dev/null || true

cd "$dotfiles"
./scripts/preferences.sh
./scripts/brew.sh

# Change default shell to Homebrew zsh
echo "Changing default shell to Homebrew zsh"
brew_zsh="$(brew --prefix)/bin/zsh"
if ! grep -q "$brew_zsh" /etc/shells; then
  echo "$brew_zsh" | sudo tee -a /etc/shells >/dev/null
fi
chsh -s "$brew_zsh"

# Symlinks
echo "Setting up symlinks"
mkdir -p ~/.config ~/Library/KeyBindings

# ~/.config/ items
for dir in "$dotfiles"/.config/*/; do
  name="$(basename "$dir")"
  ln -sfn "$dotfiles/.config/$name" ~/.config/"$name"
done

# ~/ dot files
ln -sf "$dotfiles/zsh/.zshrc" ~/.zshrc
ln -sf "$dotfiles/zsh/.zshenv" ~/.zshenv
ln -sf "$dotfiles/git/.gitconfig" ~/.gitconfig
ln -sf "$dotfiles/git/.gitignore_global" ~/.gitignore_global
ln -sf "$dotfiles/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$dotfiles/ideavim/.ideavimrc" ~/.ideavimrc
ln -sf "$dotfiles/keybindings/Library/KeyBindings/DefaultKeyBinding.dict" ~/Library/KeyBindings/DefaultKeyBinding.dict
find "$dotfiles/vscode/Library/Application Support/Code/User" -type f -exec ln -sf {} ~/Library/Application\ Support/Code/User/ \;

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
