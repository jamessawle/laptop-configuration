{ config, pkgs, pkgs-unstable, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "vscode"
    ];

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        ident_style = "space";
        ident_size = 2;
      };
    };
  };

  fonts.fontconfig.enable = true;

  home = {
    stateVersion = "24.05"; # Read home-manager changelog before changing.
    preferXdgDirectories = true;

    packages = with pkgs; [
      circleci-cli
      fnm
      k6
      neofetch
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      ruby
    ];

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  imports = [
    ./modules/bat.nix
    ./modules/git.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/vscode.nix
    ./modules/zsh.nix
  ];

  programs = {
    awscli.enable = true;

    bottom = {
      enable = true;
    };

    home-manager.enable = true;

    java.enable = true;

    oh-my-posh = {
      enable = true;
      useTheme = "catppuccin_mocha";
    };

    poetry.enable = true;

    ssh = {
      enable = true;
      extraConfig = "IdentityAgent ~/.1password/agent.sock";
    };
  };
}
