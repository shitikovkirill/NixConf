let hosts = import ./load-hosts.nix;
in {
  networking.hosts = ({ "0.0.0.0" = [ "account.jetbrains.com" ]; }) // hosts;
}
