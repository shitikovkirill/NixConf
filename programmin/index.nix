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
   ];
}
