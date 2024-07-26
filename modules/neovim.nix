{ pkgs, pkgs-unstable, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    extraPackages = with pkgs; [
      fd
      fish
      lazygit
      lua
      luarocks
      ripgrep
      tree-sitter
      wget
    ];
  };
}