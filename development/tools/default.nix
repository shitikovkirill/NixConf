{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      bruno
      xmind
    ];

    imports = [
      ./jetbrains.nix
    ];
}