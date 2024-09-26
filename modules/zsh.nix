{ ... }:
{
  programs.zsh = {
    enable = true;
    antidote = {
      enable = true;
      plugins = [
        "agkozak/zsh-z"
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
      npm-aws = "aws sso login --profile artefacts-engineer && export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain gousto --domain-owner 472493421475 --query authorizationToken --output text --profile artefacts-engineer` && aws codeartifact login --tool npm --repository proxy-repository --domain gousto --domain-owner 472493421475 --profile artefacts-engineer";
      npm-reset = "npm config set registry https://registry.npmjs.org/";
      ".." = "cd ..";
    };

    initExtra = ''
      eval "$(fnm env --use-on-cd)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}


