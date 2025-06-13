{ config, lib, pkgs, ... }:
{
  options = {
    neovim.enable = lib.mkEnableOption "Enable neovim editor";
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        cargo
        lazygit
        ripgrep
      ];
    };
  };
}
