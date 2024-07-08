{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      # Text editor
      featherpad
    ];
}

