let
  hosts = import ./load-hosts.nix;
in
{
networking.extraHosts =
  ''
    0.0.0.0 account.jetbrains.com
  '';

  networking.hosts = ({
    
  })// hosts;
}
