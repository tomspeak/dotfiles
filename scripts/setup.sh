#!/bin/bash

# Ask for the administrator password upfront
sudo -v

read -p "Pass an absolute path to the dotfiles folder, e.g. /Users/t/dotfiles" dotfiles

echo "Silencing terminal login messages"
touch ~/.hushlogin

echo "Creating workspace folder"
mkdir -p ~/workspace/

echo "Installing Xcode CLI tools"
xcode-select --install

./preferences.sh

./brew.sh

# Add the Homebrew zsh to allowed shells
echo "Changing default shell to Homebrew zsh"
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells >/dev/null
# Set the Homebrew zsh as default shell
chsh -s "$(brew --prefix)/bin/zsh"

#echo "Installing oh-my-zsh"
#if [ ! -r ~/.oh-my-zsh ]; then
#curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
#else
#echo 'oh-my-zsh already installed'
#fi

echo "Setting symlinks"
mkdir -p ~/.config/
ln -sf "$dotfiles/zsh/zshrc" ~/.zshrc
ln -sf "$dotfiles/applescripts" ~/.applescripts
ln -sf "$dotfiles/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$dotfiles/tmux/theme.sh" ~/.tmux/theme.sh
ln -sf "$dotfiles/git/gitconfig" ~/.gitconfig
ln -sf "$dotfiles/git/gitignore_global" ~/.gitignore_global
ln -sf "$dotfiles/nvim/" ~/.config/nvim/
ln -sf "$dotfiles/karabiner" ~/.config
ln -sf "$dotfiles/starship.toml" ~/.config
ln -sf "$dotfiles/ghostty" ~/.config
ln -sf "$dotfiles/spacebar" ~/.config/
ln -sf "$dotfiles/skhdrc" ~/.config/
#ln -sf "$dotfiles/fish" ~/.config
ln -sf "$dotfiles/bash/bashrc" ~/.bashrc
mkdir -p ~/Library/KeyBindings/
ln -sf "$dotfiles/DefaultKeyBinding.dict" ~/Library/KeyBindings/
find "$dotfiles/vscode" -type f -exec ln -sf {} ~/Library/Application\ Support/Code/User/ \;

echo "Installing tmux plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Starting services"
skhd --install-service
yabai --install-service

echo "Open a tmux session and do PREFIX + U to install plugins. Press enter to continue..."
read -r

echo "Install Ghostty https://github.com/ghostty-org/ghostty/releases/tag/tip Press enter to continue..."
read -r

echo "Install fonts. Press enter to continue..."
read -r

echo "Set wallpaper to black and screensaver to ~/dotfiles/wallpaper/. Press enter to continue..."
read -r

echo "Setup complete, log out and in again :)"
