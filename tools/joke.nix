{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     cowsay
     figlet
     toilet
   ];
}
