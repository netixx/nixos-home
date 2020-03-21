{ config, pkgs, ... }:

{
  services.netdata = {
      enable= true;
      configText = ''
        [global]
          web files owner = root
          web files group = root
          debug log = /dev/null
          access log = syslog
          error log = syslog
        [registry]
          enabled = ${if config.home.netdataRegistry then "yes" else "no"}
          registry to announce = https://netdata.sup.infra.xinet.fr
      '';
  };
}
