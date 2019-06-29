let
  hosts = import ./load-hosts.nix;
in
{
networking.extraHosts =
  ''
    0.0.0.0 account.jetbrains.com
    0.0.0.0 stag.loc
  '';

  networking.hosts = ({
    
  })// hosts;
}
