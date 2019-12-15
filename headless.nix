{ config, lib, pkgs, ... }:

{
  # manual no xlibs
  # programs.ssh.setXAuthLocation = false;
  # security.pam.services.su.forwardXAuth = lib.mkForce false;

  # fonts.fontconfig.enable = false;

  # nixpkgs.overlays = lib.singleton (lib.const (super: {
  #   # dbus = super.dbus.override { x11Support = false; };
  #   networkmanager-fortisslvpn = super.networkmanager-fortisslvpn.override { withGnome = false; };
  #   networkmanager-l2tp = super.networkmanager-l2tp.override { withGnome = false; };
  #   networkmanager-openconnect = super.networkmanager-openconnect.override { withGnome = false; };
  #   networkmanager-openvpn = super.networkmanager-openvpn.override { withGnome = false; };
  #   networkmanager-vpnc = super.networkmanager-vpnc.override { withGnome = false; };
  #   networkmanager-iodine = super.networkmanager-iodine.override { withGnome = false; };
  #   pinentry = super.pinentry.override { gtk2 = null; gcr = null; qt4 = null; qt5 = null; };
  #   gobject-introspection = super.gobject-introspection.override { x11Support = false; };
  # }));
  environment.noXlibs = true;
  sound.enable = false;
  boot.vesa = false;

  boot.kernelParams = lib.mkAfter [ "panic=1" "boot.panic_on_fail" ];
}
