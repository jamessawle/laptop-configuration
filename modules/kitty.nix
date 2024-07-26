{ ... }:
{
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = [
      "--listen-on=unix:/tmp/mykitty --single-instance"
    ];
    font.name = "FiraCode Nerd Font Mono";
    theme = "Catppuccin-Mocha";
    shellIntegration.enableZshIntegration = true;
  };
}
