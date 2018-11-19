{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      python36Full
      python36Packages.distutils_extra

      python36Packages.virtualenv
      python36Packages.virtualenvwrapper

      pipenv

      pypi2nix
   ];
}
