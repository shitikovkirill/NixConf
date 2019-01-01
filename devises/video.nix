{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
      vbetool
   ];
}
