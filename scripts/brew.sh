#!/bin/bash

# Install Homebrew if it isn't already installed
if ! command -v brew &>/dev/null; then
	echo "Homebrew not installed. Installing Homebrew."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew is already installed."
fi

# Verify brew is now accessible
if ! command -v brew &>/dev/null; then
	echo "Failed to configure Homebrew in PATH. Please add Homebrew to your PATH manually."
	exit 1
fi

echo "Create 10 Spaces for Yabai to use. Press enter to continue..."
read -r

echo "Installing brew casks and apps"
brew tap Homebrew/bundle
brew tap FelixKratz/formulae
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew bundle

echo "Give permissions to SKHD, Yabai, Alfred, SketchyBar, Karabiner. Press enter to continue..."
read -r

echo "Sign in to Spotify. Press enter to continue..."
read -r

echo "Sign in to 1Password. Press enter to continue..."
read -r

echo "Sign in to Dropbox. Press enter to continue..."
read -r

echo "Sign in to Discord. Press enter to continue..."
read -r

echo "Sign in to Signal. Press enter to continue..."
read -r

echo "Sign in to Alfred (License). Press enter to continue..."
read -r

echo "Sign in to CleanShot (License). Press enter to continue..."
read -r
