let hosts = import ./load-hosts.nix;
in {
  networking.hosts = hosts;
}
