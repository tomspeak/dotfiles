#!/bin/bash
set -euo pipefail

# Portable settings from com.superlogical.rex.
# Quit Rex before applying, then reopen it. Do not symlink its live plist:
# macOS caches and rewrites it, and it also contains session/machine state.
domain=com.superlogical.rex

# Appearance
defaults write "$domain" Workspace.appearance -string system
defaults write "$domain" Workspace.darkThemeID -string silver-point-dark
defaults write "$domain" Workspace.lightThemeID -string merino-light
defaults write "$domain" Workspace.darkUsesExtendedThemePalette -bool true
defaults write "$domain" Workspace.interfaceStyle -string blendTheme
defaults write "$domain" Workspace.inactivePaneFadeMode -string styling
defaults write "$domain" Workspace.paneDensity -string compact
defaults write "$domain" Workspace.showsActivePaneBorder -bool false
defaults write "$domain" Workspace.usesPaneGlass -bool false
defaults write "$domain" Workspace.usesStandardInactiveWindowPaneStyles -bool true

# Sidebar and tabs
defaults write "$domain" Workspace.sidebarPosition -string left
defaults write "$domain" Workspace.tabStyle -string horizontal
defaults write "$domain" Workspace.tabIconCount -int 0
defaults write "$domain" Workspace.tabIconTintMode -string off

# Terminal
defaults write "$domain" Workspace.terminalFontName -string TX-02
defaults write "$domain" Workspace.terminalFontPointSize -int 14
defaults write "$domain" Workspace.terminalCellHeightPercent -int 4
defaults write "$domain" Workspace.terminalFontSmoothing -bool true
defaults write "$domain" Workspace.terminalImproveTextContrast -bool false
defaults write "$domain" Workspace.terminalUsesDisplayP3 -bool true
defaults write "$domain" Workspace.terminalUseThemePalette -bool false
defaults write "$domain" Workspace.terminalCopyAnimation -bool true
defaults write "$domain" Workspace.terminalCursorStyle -string block
defaults write "$domain" Workspace.terminalCursorBlinkIntervalMilliseconds -int 500
defaults write "$domain" Workspace.terminalCursorBlinkUsesCustomInterval -bool false

# Agents and local server
defaults write "$domain" rex.agents.names-sessions -bool true
defaults write "$domain" rex.server.automatic-restart-enabled -bool true
defaults write "$domain" rex.server.block-plugin-reload-enabled -bool false
defaults write "$domain" rex.server.run-mode -string bundled
defaults write "$domain" rex.server.web-client-origin-patterns -array https://rex.superlogical.com

echo "Rex preferences saved. Reopen Rex to apply them."
