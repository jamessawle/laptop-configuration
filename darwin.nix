{ config, pkgs, ... }:

{
  # Auto upgrade nix package
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  system = {
    primaryUser = "james.sawle";

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    brews = [
      "docker-compose"
    ];

    casks = [
      "1password"
      "1password-cli"
      # "google-chrome"
      "karabiner-elements"
      "logseq"
      "nosql-workbench"
      "plover"
      "postman"
      "raycast"
      # "slack"
      "tableplus"
    ];
  };
}
