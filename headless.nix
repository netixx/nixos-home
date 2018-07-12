{ config, lib, pkgs, ... }:

{
  environment.noXlibs = true;
  sound.enable = false;
  boot.vesa = false;

  boot.kernelParams = lib.mkAfter [ "panic=1" "boot.panic_on_fail" ];
}
