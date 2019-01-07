{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     gnumake
     heroku
   ];

   imports = [
     ./tools/git.nix
     ./tools/docker.nix
     ./tools/ide.nix
     ./tools/js.nix
     ./tools/vagrant.nix
     ./tools/python.nix
     ./tools/bash.nix
     ./python.nix
     ./php.nix
   ];
}
