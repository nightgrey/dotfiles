# FINDER

# Reveal hidden files
defaults write com.apple.finder AppleShowAllFiles -string YES
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# TRACKPAD, KEYBOARD

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# Tap bottom right corner for a right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
# Disable "natural" scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# DOCK

# Don’t show recent applications
defaults write com.apple.dock show-recents -bool false
