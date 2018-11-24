{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      python36Full

      pypi2nix

      python36Packages.pylint
   ];
}
