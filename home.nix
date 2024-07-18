{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "vscode"
    ];

  fonts.fontconfig.enable = true;

  home = {
    stateVersion = "24.05"; # Read home-manager changelog before changing.
    preferXdgDirectories = true;

    packages = [
      pkgs.circleci-cli
      pkgs.fnm
      pkgs.k6
      pkgs.neofetch
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
      pkgs.ruby
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'. But this allows for copying whole files.
    file = {
    };

    sessionVariables = {
    };
  };

  programs = {
    awscli.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "macchiato";
      };
      themes = {
        macchiato = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "d714cc1d358ea51bfc02550dabab693f70cccea0";
            sha256 = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
          };
          file = "themes/Catppuccin\ Macchiato.tmTheme";
        };
      };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    git = {
      enable = true;
      lfs.enable = true;

      userName = "James Sawle";
      userEmail = "jamessawle@hotmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
      };
    };

    java.enable = true;

    kitty = {
      enable = true;
      darwinLaunchOptions = [
        "--single-instance"
      ];
      font.name = "FiraCode Nerd Font Mono";

      shellIntegration.enableZshIntegration = true;
      settings = {
        # catppuccin macchiato theme
        # The basic colors
        foreground = "#cad3f5";
        background = "#24273a";
        selection_foreground = "#24273a";
        selection_background = " #f4dbd6";

        # Cursor colors
        cursor = "#f4dbd6";
        cursor_text_color = "#24273a";

        # URL underline color when hovering with mouse
        url_color = "#f4dbd6";

        # Kitty window border colors
        active_border_color = "#b7bdf8";
        inactive_border_color = "#6e738d";
        bell_border_color = "#eed49f";

        # OS Window titlebar colors
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";

        # Tab bar colors
        active_tab_foreground = "#181926";
        active_tab_background = "#c6a0f6";
        inactive_tab_foreground = "#cad3f5";
        inactive_tab_background = "#1e2030";
        tab_bar_background = "#181926";

        # Colors for marks (marked text in the terminal)
        mark1_foreground = "#24273a";
        mark1_background = "#b7bdf8";
        mark2_foreground = "#24273a";
        mark2_background = "#c6a0f6";
        mark3_foreground = "#24273a";
        mark3_background = "#7dc4e4";

        # The 16 terminal colors
        # black
        color0 = "#494d64";
        color8 = "#5b6078";

        # red
        color1 = "#ed8796";
        color9 = "#ed8796";

        # green
        color2  = "#a6da95";
        color10 = "#a6da95";

        # yellow
        color3 = "#eed49f";
        color11 = "#eed49f";

        # blue
        color4 = "#8aadf4";
        color12 = "#8aadf4";

        # magenta
        color5 = "#f5bde6";
        color13 = "#f5bde6";

        # cyan
        color6 = "#8bd5ca";
        color14 = "#8bd5ca";

        # white
        color7 = "#b8c0e0";
        color15 = "#a5adcb";
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    oh-my-posh = {
      enable = true;
      useTheme = "sim-web";
    };

    poetry.enable = true;

    ssh = {
      enable = true;
      extraConfig = "IdentityAgent ~/.1password/agent.sock";
    };

    vscode = {
      enable = true;
      extensions = (with pkgs.vscode-extensions; [
        bbenoist.nix
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        github.vscode-github-actions
      ]);
      userSettings = {
        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "editor.accessibilitySupport" = "off";
        "editor.fontFamily" = "'FiraCode Nerd Font', Monaco, 'Courier New', monospace";
        "editor.fontLigatures" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.largeFileOptimizations" = true;
        "security.workspace.trust.banner" = "always";
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";
        "editor.fontSize" = 8;
        "git.ignoreRebaseWarning" = true;
        "circleci.hostUrl" = "";
        "window.zoomLevel" = 4;
        "diffEditor.ignoreTrimWhitespace" = false;
      };
    };

    zsh = {
      enable = true;
      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-autosuggestions"
          "zsh-users/zsh-completions"
          "zsh-users/zsh-history-substring-search"
        ];
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        cat = "bat";
        ll = "ls -l";
        npm-aws = "aws sso login --profile codeartifact && export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain gousto --domain-owner 472493421475 --query authorizationToken --output text --profile codeartifact` && aws codeartifact login --tool npm --repository proxy-repository --domain gousto --domain-owner 472493421475 --profile codeartifact";
        npm-reset = "npm config set registry https://registry.npmjs.org/";
        ".." = "cd ..";
      };
      initExtra = ''
        eval "$(fnm env --use-on-cd)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };
}
