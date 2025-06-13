{ pkgs, config, lib, ... }:

let
  moduleFiles = builtins.attrNames (builtins.readDir ./modules);
  modulePaths = builtins.filter (file: lib.hasSuffix ".nix" file) moduleFiles;
in {
  imports = map (file: ./modules + "/${file}") modulePaths;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ 
    "vscode"
    "vscode-extension-ms-vsliveshare-vsliveshare"
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
    stateVersion = "25.05"; # Read home-manager changelog before changing.
    preferXdgDirectories = true;

    packages = with pkgs; [
      circleci-cli
      colima
      docker
      elixir
      elixir_ls
      fnm
      k6
      neofetch
      nerd-fonts.fira-code
      nodePackages.aws-cdk
      qmk
      ruby
      uv
    ];

    sessionPath = [ 
      "$HOME/.local/bin"
      "$HOME/Library/Python/3.9/bin" 
    ];
  };

  bat.enable = true;
  git.enable = true;
  kitty.enable = true;
  macos.enable = true;
  neovim.enable = true;
  vscode.enable = true;

  programs = {
    awscli.enable = true;

    bottom.enable = true;

    gpg.enable = true;

    home-manager.enable = true;

    java.enable = true;

    oh-my-posh = {
      enable = true;
      useTheme = "catppuccin_mocha";
    };

    poetry = {
      enable = true;
      settings = {
        cache-dir = "~/.cache/poetry";
      };
    };

    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };

    ssh = {
      enable = true;
      extraConfig = "IdentityAgent \"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
