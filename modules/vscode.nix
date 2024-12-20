{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = (with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      eamodio.gitlens
      elixir-lsp.vscode-elixir-ls
      github.vscode-github-actions
      jnoortheen.nix-ide
      ms-azuretools.vscode-docker
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
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "editor.fontSize" = 8;
      "git.ignoreRebaseWarning" = true;
      "circleci.hostUrl" = "";
      "window.zoomLevel" = 1;
      "diffEditor.ignoreTrimWhitespace" = false;
    };
  };
}
