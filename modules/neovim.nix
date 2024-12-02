{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
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
