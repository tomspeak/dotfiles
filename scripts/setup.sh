#!/bin/bash

# Ask for the administrator password upfront
sudo -v

read -pr "Pass an absolute path to the dotfiles folder, e.g. /Users/t/dotfiles" dotfiles

echo "Creating workspace folder"
mkdir -p ~/workspace/

echo "Installing Xcode CLI tools"
xcode-select --install

echo "Installing Homebrew"
if ! hash brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing brew casks and apps"
brew tap Homebrew/bundle
brew tap caskroom/versions
brew tap caskroom/cask
brew tap FelixKratz/formulae
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew bundle

echo "Installing oh-my-zsh"
if [ ! -r ~/.oh-my-zsh ]; then
	curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
else
	echo 'oh-my-zsh already installed'
fi

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
mkdir -p ~/Library/KeyBindings/
ln -sf "$dotfiles/DefaultKeyBinding.dict" ~/Library/KeyBindings/
find "$dotfiles/vscode" -type f -exec ln -sf {} ~/Library/Application\ Support/Code/User/ \;

echo "Installing tmux plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Starting services"
skhd --start-service
yabai --start-service
brew services start sketchybar

echo "Setting preferences"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

defaults delete com.apple.dock && killall Dock
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock no-bouncing -bool TRUE
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock enable-sprint-loaded-actions-on-all-items -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "orientation" -string "bottom"
defaults write com.apple.dock "show-recents" -bool "false"

defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

defaults write -g com.apple.mouse.scaling -float 5.0
defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"
defaults write NSGlobalDomain com.apple.mouse.scaling -float "2"
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

defaults write com.apple.universalaccess reduceTransparency -bool true

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain NSUseAnimatedRing -bool false
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write com.apple.HIToolbox AppleFnUsageType -int "0"
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Disable local Time Machine snapshots
sudo tmutil disablelocal

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture "disable-shadow" -bool "true"
defaults write com.apple.screencapture "include-date" -bool "true"

defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true"

defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write com.apple.dock "expose-group-apps" -bool "false"
defaults write NSGlobalDomain "AppleSpacesSwitchOnActivate" -bool "true"
defaults write com.apple.spaces "spans-displays" -bool "true"
defaults write com.apple.spaces "spans-displays" -bool "true"

defaults write com.apple.Finder AppleShowAllFiles true
# Show the ~/Library folder
chflags nohidden ~/Library
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder EmptyTrashSecurely -bool true
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

defaults write NSGlobalDomain Acom.apple.springing.enabled -bool true
defaults write NSGlobalDomain Acom.apple.springing.delay -float 0

defaults write com.apple.finder "CreateDesktop" -bool "false"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "false"

defaults write com.apple.Music "userWantsPlaybackNotifications" -bool "false"

defaults write com.apple.mail DisableReplyAnimations - bool true
defaults write com.apple.mail DisableSendAnimations -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"
# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

defaults write com.apple.LaunchServices "LSQuarantine" -bool "false"

sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor IconType -int 5
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

killall Dock
killall Finder
killall Safari
killall SystemUIServer
killall Music
killall Activity Monitor
killall Calendar
killall Mail
killall cfprefsd

echo "Preferences set"

echo "Setup complete, remaining steps:"
echo "1. Logout"
echo "2. Open a tmux session and do PREFIX + U to install plugins"
echo "3. Install Ghostty - https://github.com/ghostty-org/ghostty/releases/tag/tip"
