{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.home-manager
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;  # Create /etc/zshrc that loads the nix-darwin environment.
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      "1password"
      "google-chrome"
      "iterm2"
      "logseq"
      "nosql-workbench"
      "plover"
      "postman"
      "raycast"
      "slack"
      "tableplus"
    ];
  };

  system.defaults = {
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
    dock = {
      autohide = true;
      autohide-time-modifier = 1.5;
      persistent-apps = [
        "/Users/james.sawle/Applications/Home\ Manager\ Apps/Visual\ Studio\ Code.app"
        "/Users/james.sawle/Applications/Home\ Manager\ Apps/kitty.app"
      ];
      persistent-others = [
        "/Users/james.sawle/Downloads"
      ];
    };
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };
    magicmouse = {
      MouseButtonMode = "TwoButton";
    };
    CustomUserPreferences = {
      # Show battery percentage
      "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
      # Privacy
      "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
    };
  };
}
