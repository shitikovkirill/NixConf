{ config, pkgs, ... }:

{
networking.extraHosts =
  ''
    0.0.0.0 account.jetbrains.com
  '';
}
