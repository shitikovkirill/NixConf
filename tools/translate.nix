{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     poedit

     gettext
   ];
}
