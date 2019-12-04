{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fzf
  ];

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

      ${pkgs.any-nix-shell} zsh --info-right | source /dev/stdin

      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
      fi
    '';

    ohMyZsh.customPkgs = with pkgs; [
      pkgs.nix-zsh-completions
      pkgs.zsh-completions
    ];
    /*ohMyZsh = {
      enable = true;
      theme = "funky";
    };*/

    promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh
  };

  programs.screen.screenrc = ''
    defscrollback 5000
    termcapinfo xterm* ti@:te@

    escape ^Ff
    #caption always "%{-b ..}%-w%{+b ..}[[%n%f*%t]]%{-}%+w"

    autodetach on
    startup_message off
    hardstatus alwayslastline
    shelltitle 'bash'

    hardstatus string '%{gk}[%{wk}%?%-Lw%?%{=b kR}(%{W}%n*%f %t%?(%u)%?%{=b kR})%{= w}%?%+Lw%?%? %{g}][%{d}%l%{g}][ %{= w}%Y/%m/%d %0C:%s%a%{g} ]%{W}'
  '';

  users.users.root.shell = "/run/current-system/sw/bin/zsh";
  users.mutableUsers = false;
}
