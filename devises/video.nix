{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
      vokoscreen
      vlc
   ];
}
