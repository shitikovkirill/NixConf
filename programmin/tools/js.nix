{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     lessc
     sass

     nodejs
     watchman
     phantomjs2

     yarn

     nodePackages.node2nix
   ];
}
