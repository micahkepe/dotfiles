#!/usr/bin/env bash

# macOS Setup Script - Compatible with macOS 15 Sequoia & 26 Tahoe
#
# Sources:
# - https://macos-defaults.com
# - https://grishy.dev/en/posts/macOS-setup-2025/
set -Eeuo pipefail

# Finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true # show POSIX path in title bar
defaults write com.apple.finder ShowPathbar -bool true             # Show path bar
defaults write com.apple.finder ShowStatusBar -bool true           # Shows status bar
defaults write NSGlobalDomain AppleShowAllExtensions -bool true    # Always show file extensions
defaults write com.apple.finder QuitMenuItem -bool true            # Show "Quit Finder"
defaults write com.apple.finder DisableAllAnimations -bool true    # Disable all animations
defaults write com.apple.finder _FXSortFoldersFirst -bool true     # Sort folders before files

# Keyboard
defaults write -g InitialKeyRepeat -float 10.0 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -float 1.0         # normal minimum is 2 (30 ms)

# Auto-hide Dock
defaults write com.apple.dock autohide -bool true

# Fast Dock animations
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock autohide-delay -float 0

# Hide recent applications
defaults write com.apple.dock show-recents -bool false

# Make hidden app icons translucent
defaults write com.apple.dock showhidden -bool true

# Disable Spotlight web search (keeps searches local)
defaults write com.apple.lookup.shared LookupSuggestionsDisabled -bool true

# Disable crash reporter dialog
defaults write com.apple.CrashReporter DialogType -string "none"

# Restart affected services
for app in "Finder" "Dock" "SystemUIServer" "WindowManager"; do
  killall "${app}" &>/dev/null || true
done

# Restart preference daemon
killall cfprefsd
