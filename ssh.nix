{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    permitRootLogin = "${if config.home.sshAsRoot then "yes" else "no"}";
  };

  systemd.services.sshd.wants = [ "network-online.target" ];
  systemd.services.sshd.after = [ "network-online.target" ];
}
