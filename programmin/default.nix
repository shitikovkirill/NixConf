{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     gnumake
     heroku
     
     ngrok
   ];

   imports = [
     ./tools/git.nix
     ./tools/docker.nix
     ./tools/ide.nix
     ./tools/js.nix
     ./tools/vagrant.nix
     ./tools/vagga.nix
     ./tools/python.nix
     ./tools/bash.nix
     ./tools/cloud.nix
     #./tools/nix-tools.nix
     #./go.nix
     #./python.nix
     #./php.nix
   ];
}
