{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     php
     php72Packages.composer
   ];

   environment.variables.PATH = "~/.config/composer/vendor/bin/:$PATH";
}
