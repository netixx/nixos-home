{ config, pkgs, ... }:

{
  services.journald.extraConfig = ''
    MaxRetentionSec=1week
  '';
  services.syslog-ng = {
    enable=true;
    configHeader = ''
      @version: 3.9
      @include "scl.conf"
    '';
    extraConfig = ''
      source src {
        system();
      #  internal();
      };

      destination syslog_server { udp("${config.home.syslog}" port(514)); };

      filter f_auth { facility(auth); };
      filter f_authpriv { facility(auth, authpriv); };
      filter f_syslog { program(syslog-ng); };
      filter f_cron { facility(cron); };
      filter f_daemon { facility(daemon); };
      filter f_kernel { facility(kern) and not filter(f_iptables); };
      filter f_lpr { facility(lpr); };
      filter f_mail { facility(mail); };
      filter f_news { facility(news); };
      filter f_user { facility(user); };
      filter f_uucp { facility(uucp); };
      filter f_ppp { facility(local2); };
      filter f_debug { not facility(auth, authpriv, news, mail); };
      filter f_messages { level(info..warn) and not facility(auth, authpriv, mail, news, cron) and not program(syslog-ng) and not filter(f_iptables); };
      filter f_everything { level(debug..emerg) and not facility(auth, authpriv); };
      filter f_emergency { level(emerg); };
      filter f_info { level(info); };
      filter f_notice { level(notice); };
      filter f_warn { level(warn); };
      filter f_crit { level(crit); };
      filter f_err { level(err); };
      filter f_iptables { match("IN=" value("MESSAGE")) and match("OUT=" value("MESSAGE")); };
      filter f_acpid { program("acpid"); };

      #log { source(src); filter(f_acpid); destination(d_acpid); };
      #log { source(src); filter(f_authpriv); destination(d_authlog); };
      #log { source(src); filter(f_syslog); destination(d_syslog); };
      #log { source(src); filter(f_cron); destination(d_cron); };
      #log { source(src); filter(f_daemon); destination(d_daemon); };
      #log { source(src); filter(f_kernel); destination(d_kernel); };
      #log { source(src); filter(f_lpr); destination(d_lpr); };
      #log { source(src); filter(f_mail); destination(d_mail); };
      #log { source(src); filter(f_news); destination(d_news); };
      #log { source(src); filter(f_ppp); destination(d_ppp); };
      #log { source(src); filter(f_user); destination(d_user); };
      #log { source(src); filter(f_uucp); destination(d_uucp); };
      ##log { source(src); filter(f_debug); destination(d_debug); };
      #log { source(src); filter(f_messages); destination(d_messages); };
      #log { source(src); filter(f_err); destination(d_errors); };
      #log { source(src); filter(f_emergency); destination(d_console); };
      #log { source(src); filter(f_everything); destination(d_everything); };
      #log { source(src); filter(f_iptables); destination(d_iptables); };

      # Log everything to tty12
      #log { source(src); destination(console_all); };

      log { source(src); filter(f_messages); destination(syslog_server); };
      log { source(src); filter(f_emergency); destination(syslog_server); };
    '';
  };
}
