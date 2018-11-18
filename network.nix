{ config, pkgs, ... }:

{
networking.extraHosts =
  ''
    192.168.0.101 git.example.com

    0.0.0.0 account.jetbrains.com
  '';
}
