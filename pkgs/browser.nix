{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox-wayland
    chromium
    w3m
    filezilla
  ];
}
