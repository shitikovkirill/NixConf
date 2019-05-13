{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      scudcloud
      tdesktop
      discord
    ];
}
