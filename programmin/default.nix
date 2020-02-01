{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     gnumake
     direnv

     heroku
     
     ngrok
   ];

   imports = [
     ./tools
     #./go.nix
     #./python.nix
     #./php.nix
   ];
}
