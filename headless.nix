{ config, lib, pkgs, ... }:

{
  environment.noXlibs = true;
  sound.enable = false;
  boot.vesa = false;

  boot.kernelParams = lib.mkAfter [ "console=ttyS0,115200" "panic=1" "boot.panic_on_fail" ];
  boot.loader.grub.splashImage = null;
  boot.loader.grub.extraConfig = "serial --speed=115200; terminal_output serial; terminal_input serial";

}
