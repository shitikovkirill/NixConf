{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     php
     php72Packages.composer
   ];
}
