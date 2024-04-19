{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Text editor
    featherpad

    # Flash OS images to SD cards
    etcher
  ];
}

