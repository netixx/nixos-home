{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    /*enableAutosuggestions = true;*/
    /*enableSyntaxHighlighting = true;*/
    enableCompletion = true;
    interactiveShellInit = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
      ZSH_CACHE_DIR=''${XDG_CACHE_HOME:-$HOME/.cache}/zsh
      zstyle ':completion:*' cache-path ~/.zsh/cache

      # Customize your oh-my-zsh options here
      ZSH_THEME="funky"
      plugins=()

      source $ZSH/oh-my-zsh.sh
    '';
    /*ohMyZsh = {
      enable = true;
      theme = "funky";
    };*/

    promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  };

  users.users.root.shell = "/run/current-system/sw/bin/zsh";
  users.mutableUsers = false;
}
