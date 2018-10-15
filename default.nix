{ config, lib, pkgs, ... }:
with lib;
{
    options = {
        home = {
            domain = mkOption {
                type = types.str;
                default = "xinet.fr";
                description = "Domain to use";
            };

            syslog = mkOption {
                type = types.str;
                default = "syslog.${config.home.domain}";
                description = "IP address of the syslog server in the network";
            };

            netdataRegistry = mkOption {
                type = types.bool;
                default = false;
                description = "Wheather to configure this host has netdata registry";
            };

            sshAsRoot = mkOption {
                type = types.bool;
                default = false;
                description = "Wether to enable root login via SSH";
            };

            dns = mkOption {
                type = types.str;
                default = "1.1.1.1";
                description = "DNS server to use";
            };
        };
    };

    imports = [
        ./monitoring.nix
        ./shell.nix
        ./ssh.nix
        ./syslog.nix
        ./tools.nix
    ];

    config.system.copySystemConfiguration = true;
}
