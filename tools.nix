{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tcpdump
    htop
    vim
  ];
}
