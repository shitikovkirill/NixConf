{ config, pkgs, ... }:

{
   programs.bash.enableCompletion = true;
   nixpkgs.config.allowUnfree = true;

   environment.systemPackages = with pkgs; [
     atom
     insomnia
     postman
   ];

   imports = [
     ./jetbrains.nix
   ];
}
