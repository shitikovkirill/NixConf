{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     lessc
     nodejs
     nodePackages.node2nix
     phantomjs2
     sass
     yarn
   ];
}
