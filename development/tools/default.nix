{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      bruno
      xmind
    ];
}