{ config, lib, ... }:
{
  options = {
    kitty.enable = lib.mkEnableOption "Enable kitty terminal";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      darwinLaunchOptions = [
        "--listen-on=unix:/tmp/mykitty --single-instance"
      ];
      font.name = "FiraCode Nerd Font Mono";
      themeFile = "Catppuccin-Mocha";
      shellIntegration.enableZshIntegration = true;
    };
  };
}
