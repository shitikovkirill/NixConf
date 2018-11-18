{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      pypi2nix
   ];
}
