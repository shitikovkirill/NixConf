{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tdesktop
    #discord
    #zoom-us
    skypeforlinux
    slack
    #teams
  ];
}
