{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    chromium
    flood
    # w3m
    # filezilla
    # opera
  ];
}
