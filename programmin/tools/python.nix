{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      python36Full

      pypi2nix

      nixos.python36Packages.virtualenv
   ];
}
