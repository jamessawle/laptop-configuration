{ config, lib, ... }:
let
  cfg = config.git;  # define cfg here for convenience
in
{
  options.git = {
    enable = lib.mkEnableOption "Enable git";

    gh.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable github CLI tool";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      # enable gh CLI tool if requested
      gh = lib.mkIf cfg.gh.enable {
        enable = true;

        settings = {
          git_protocol = "ssh";
          prompt = "enabled";
        };
      };

      # git config
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
    };
  };
}
