let hosts = import ./load-hosts.nix;
in {
  networking.extraHosts = ''
    0.0.0.0 account.jetbrains.com
    0.0.0.0 stag.loc
    192.168.1.120 git.webwave.loc
    192.168.1.120 db.webwave.loc
    192.168.1.120 mail.webwave.loc
    192.168.1.120 grafana.webwave.loc
    192.168.1.120 prometeus.webwave.loc
  '';

  networking.hosts = ({

  }) // hosts;
}
