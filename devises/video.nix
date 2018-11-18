{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
      vokoscreen
      vlc
      youtube-dl
   ];

   hardware.bumblebee.enable = true;
}
