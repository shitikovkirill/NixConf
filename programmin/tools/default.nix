{ config, pkgs, ... }:

{

   imports = [
     ./git.nix
     ./docker.nix
     ./ide.nix
     ./js.nix
     ./vagrant.nix
     ./vagga.nix
     ./python.nix
     ./bash.nix
     ./cloud.nix
     ./direnv.nix
   ];
}
