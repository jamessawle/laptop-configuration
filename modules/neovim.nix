{ pkgs, pkgs-unstable, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    extraPackages = with pkgs; [
      cargo
      fd
      fish
      gcc
      lazygit
      lua
      luarocks
      nixd
      nixfmt-rfc-style
      ripgrep
      tree-sitter
      wget
    ];
  };
}
