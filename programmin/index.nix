{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     gnumake
     heroku
   ];

   imports = [
     ./tools/git.nix
     ./tools/gitlab/gitlab.nix
     ./tools/docker/docker.nix
     ./tools/ide.nix
     ./tools/jenkins.nix
     #./tools/js.nix
     #./tools/vagrant.nix
     #./php.nix
   ];
}
