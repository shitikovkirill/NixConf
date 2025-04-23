let hosts = import ./load-hosts.nix;
in {
  networking.hosts = hosts;
  networking.firewall.allowedTCPPortRanges = [{
    from = 30000;
    to = 50000;
  }];
  networking.firewall.allowedUDPPortRanges = [{
    from = 30000;
    to = 50000;
  }];
}
