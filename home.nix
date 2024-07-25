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

    packages = [
      pkgs.circleci-cli
      pkgs.fd
      pkgs.fish
      pkgs.fnm
      pkgs.k6
      pkgs.lazygit
      pkgs.lua
      pkgs.luarocks
      pkgs.neofetch
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
      pkgs.ripgrep
      pkgs.ruby
      pkgs.tree-sitter
      pkgs.wget
    ];

    sessionPath = [
      "$HOME/.local/bin"
    ];
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
          file = "themes/Catppuccin\ Mocha.tmTheme";
        };
      };
    };

    bottom = {
      enable = true;
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
        "--listen-on=unix:/tmp/mykitty --single-instance"
      ];
      font.name = "FiraCode Nerd Font Mono";

      shellIntegration.enableZshIntegration = true;
      settings = {
        # catppuccin mocha theme
        # The basic colors
        foreground = "#cdd6f4";
        background = "#1e1e2e";
        selection_foreground = "#1e1e2e";
        selection_background = " #f5e0dc";

        # Cursor colors
        cursor = "#f5e0dc";
        cursor_text_color = "#1e1e2e";

        # URL underline color when hovering with mouse
        url_color = "#f5e0dc";

        # Kitty window border colors
        active_border_color = "#b4befe";
        inactive_border_color = "#6c7086";
        bell_border_color = "#f9e2af";

        # OS Window titlebar colors
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";

        # Tab bar colors
        active_tab_foreground = "#11111b";
        active_tab_background = "#cba6f7";
        inactive_tab_foreground = "#cdd6f4";
        inactive_tab_background = "#181825";
        tab_bar_background = "#11111b";

        # Colors for marks (marked text in the terminal)
        mark1_foreground = "#1e1e2e";
        mark1_background = "#b4befe";
        mark2_foreground = "#1e1e2e";
        mark2_background = "#cba6f7";
        mark3_foreground = "#1e1e2e";
        mark3_background = "#74c7ec";

        # The 16 terminal colors
        # black
        color0 = "#45475a";
        color8 = "#585b70";

        # red
        color1 = "#f38ba8";
        color9 = "#f38ba8";

        # green
        color2  = "#a6e3a1";
        color10 = "#a6e3a1";

        # yellow
        color3 = "#f9e2af";
        color11 = "#f9e2af";

        # blue
        color4 = "#89b4fa";
        color12 = "#89b4fa";

        # magenta
        color5 = "#f5c2e7";
        color13 = "#f5c2e7";

        # cyan
        color6 = "#94e2d5";
        color14 = "#94e2d5";

        # white
        color7 = "#bac2de";
        color15 = "#a6adc8";
      };
    };

    neovim = {
      enable = true;
      package = pkgs-unstable.neovim-unwrapped;
      defaultEditor = true;
    };

    oh-my-posh = {
      enable = true;
      useTheme = "catppuccin_mocha";
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
        "workbench.colorTheme" = "Catppuccin Maocha";
        "workbench.iconTheme" = "catppuccin-mocha";
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
