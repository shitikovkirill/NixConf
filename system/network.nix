{ config, pkgs, ... }:

{
networking.extraHosts =
  ''
    192.168.0.121 jenkinx.comp
    192.168.0.121 staging.comp

    0.0.0.0 account.jetbrains.com
  '';
}
