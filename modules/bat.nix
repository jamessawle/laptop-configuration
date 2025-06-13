{ config, lib, pkgs, ... }:

let
  cfg = config.bat;
in {
  options.bat = {
    enable = lib.mkEnableOption "Enable bat syntax highlighting tool";

    aliasCat = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Alias 'cat' to 'bat'";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;

      config = {
        theme = "mocha";
      };

      themes = {
        mocha = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
            sha256 = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
          };
          file = "themes/Catppuccin Mocha.tmTheme";
        };
      };
    };

    home.shellAliases = lib.mkIf cfg.aliasCat {
      cat = "bat";
    };
  };
}
