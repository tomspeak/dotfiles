#!/bin/bash

# Core setup applies keyboard preferences without changing the desktop settings.
# Repeat values are in 1/60-second units: 60 repeats/s after about 167 ms.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false || exit 1
defaults write NSGlobalDomain KeyRepeat -int 1 || exit 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10 || exit 1
echo "Fast keyboard repeat saved. Log out and back in to apply it everywhere."

if [ "${1:-}" = --keyboard-only ]; then
	exit 0
fi

echo "Setting preferences"

# Appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark
defaults write NSGlobalDomain AppleAccentColor -int -1
defaults write NSGlobalDomain AppleAquaColorVariant -int 6
defaults write NSGlobalDomain AppleHighlightColor -string "1.000000 0.749020 0.823529 Pink"
defaults write NSGlobalDomain AppleReduceDesktopTinting -bool true

# British English formatting with a U.S. keyboard and 12-hour time
defaults write NSGlobalDomain AppleLanguages -array en-GB
defaults write NSGlobalDomain AppleLocale -string en_GB
defaults write NSGlobalDomain AppleICUForce12HourTime -bool true
defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string com.apple.keylayout.US
defaults write com.apple.HIToolbox AppleEnabledInputSources -array \
	'<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>' \
	'{"Bundle ID"="com.apple.CharacterPaletteIM"; InputSourceKind="Non Keyboard Input Method";}' \
	'{"Bundle ID"="com.apple.PressAndHold"; InputSourceKind="Non Keyboard Input Method";}'
defaults write com.apple.HIToolbox AppleSelectedInputSources -array \
	'<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>0</integer><key>KeyboardLayout Name</key><string>U.S.</string></dict>' \
	'{"Bundle ID"="com.apple.PressAndHold"; InputSourceKind="Non Keyboard Input Method";}'

# Disable interface sound effects and Siri
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool false
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Own the sparse application list without resetting unrelated Dock settings.
defaults write com.apple.dock persistent-apps -array \
	'{"tile-type"="spacer-tile";}' \
	'{"tile-type"="spacer-tile";}' \
	'{"tile-type"="spacer-tile";}' \
	'{"tile-type"="spacer-tile";}' \
	'{"tile-type"="spacer-tile";}' \
	'{"tile-type"="spacer-tile";}' \
	'{"tile-type"="spacer-tile";}'
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock no-bouncing -bool TRUE
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock "orientation" -string "bottom"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock mineffect -string scale

# Maximize windows by double-clicking their title bars
defaults write NSGlobalDomain AppleActionOnDoubleClick -string Maximize
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# Keep native tiling and wallpaper clicks out of Hammerspoon's way
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.WindowManager GloballyEnabled -bool false

defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

defaults write NSGlobalDomain com.apple.mouse.linear -bool "true"
defaults write NSGlobalDomain com.apple.mouse.scaling -float "2"
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1.5
# Use four-finger navigation gestures, leaving three fingers for dragging
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
	defaults write "$domain" TrackpadFourFingerHorizSwipeGesture -int 2
	defaults write "$domain" TrackpadFourFingerVertSwipeGesture -int 2
	defaults write "$domain" TrackpadFourFingerPinchGesture -int 2
	defaults write "$domain" TrackpadThreeFingerHorizSwipeGesture -int 0
	defaults write "$domain" TrackpadThreeFingerVertSwipeGesture -int 0
	defaults write "$domain" TrackpadThreeFingerTapGesture -int 0
done
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerPinchSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerTapGesture -int 0
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
defaults write com.apple.universalaccess reduceMotion -bool true
# Zoom with Option + scroll or the trackpad accessibility gesture
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -int 524288
defaults write com.apple.universalaccess closeViewTrackpadGestureZoomEnabled -bool true

# Custom green pointer with a dark outline, enlarged to about 1.23x
defaults write com.apple.universalaccess mouseDriverCursorSize -float 1.2342215776443481
defaults write com.apple.universalaccess cursorIsCustomized -bool true
defaults write com.apple.universalaccess cursorFill -dict \
	alpha -float 1 red -float 0 green -float 0.9396806359291077 blue -float 0.4967997074127197
defaults write com.apple.universalaccess cursorOutline -dict \
	alpha -float 1 red -float 0.04842541881443296 green -float 0.04842541881443296 blue -float 0.04842541881443296
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain NSUseAnimatedRing -bool false
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
defaults write com.apple.HIToolbox AppleFnUsageType -int "0"
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

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

# Enable native "Move left/right a space" (ctrl+arrow) so Karabiner's Tab+[/]
# space navigation works without popping Mission Control
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 79 "{enabled = 1; value = { parameters = ( 65535, 123, 262144 ); type = standard; }; }"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 81 "{enabled = 1; value = { parameters = ( 65535, 124, 262144 ); type = standard; }; }"

# Disable Spotlight and input-source switching shortcuts without resetting others
for shortcut in 60 61 64 65; do
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$shortcut" '<dict><key>enabled</key><false/></dict>'
done

# Ctrl+1 through Ctrl+7 switch directly to desktops 1 through 7.
# XML preserves boolean and integer types inside the shortcut dictionaries.
shortcut=118
for keycode in 18 19 20 21 23 22 26; do
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$shortcut" \
		"<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>${keycode}</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
	shortcut=$((shortcut + 1))
done

defaults write com.apple.Finder AppleShowAllFiles true
# Show the ~/Library folder
chflags nohidden ~/Library
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# Open new Finder windows at the current user's home, not a machine-specific path
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder EmptyTrashSecurely -bool true
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"
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

defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0

defaults write com.apple.finder "CreateDesktop" -bool "false"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "false"

defaults write com.apple.Music "userWantsPlaybackNotifications" -bool "false"

defaults write com.apple.mail DisableReplyAnimations -bool true
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

# Style border radius
defaults write -g NSConvolutionOverride1 -float 4
defaults write -g NSSplitViewItemSidebarDefaultsToFloatingAppearance -bool false

killall Dock
killall Finder
killall SystemUIServer

echo "Preferences set. Reopen applications to apply their settings."
