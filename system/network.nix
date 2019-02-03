{ config, pkgs, ... }:

{
networking.extraHosts =
  ''
    192.168.0.121 gitlab.comp
    192.168.0.121 jenkins.comp
    192.168.0.121 staging.comp

    0.0.0.0 account.jetbrains.com
  '';
}
