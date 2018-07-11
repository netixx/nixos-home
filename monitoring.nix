{ config, pkgs, ... }:

{
  services.netdata = {
      enable= true;
      configText = ''
        [registry]
          enabled = ${if config.home.netdataRegistry then "yes" else "no"}
          registry to announce = http://10.0.254.254:19999
      '';
  };
}
