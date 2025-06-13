{ lib, config, ... }:

{
  options = {
    macos.enable = lib.mkEnableOption "Enable macOS user default settings";
  };

  config = lib.mkIf config.macos.enable {
    home.activation.setMacDefaults = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo "Setting macOS user defaults..."

      /usr/bin/defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
      /usr/bin/defaults write com.apple.dock autohide -bool true
      /usr/bin/defaults write com.apple.dock autohide-time-modifier -float 1.5
      /usr/bin/defaults write com.apple.finder AppleShowAllExtensions -bool true
      /usr/bin/defaults write com.apple.finder ShowPathbar -bool true
      /usr/bin/defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
      /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
      /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
      /usr/bin/defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
      /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string "TwoButton"
      /usr/bin/defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter BatteryShowPercentage -bool true
      /usr/bin/defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false

      /usr/bin/killall Dock || true
      /usr/bin/killall Finder || true
      /usr/bin/killall SystemUIServer || true

      echo "macOS defaults configured."
    '';
  };
}
