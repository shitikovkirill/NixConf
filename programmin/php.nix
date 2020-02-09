{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ php php72Packages.composer ];

  environment.etc."php.d/php.ini".text = ''
    memory_limit = -1
  '';
}
