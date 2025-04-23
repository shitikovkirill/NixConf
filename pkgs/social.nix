{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tdesktop
    slack
    #discord
    #zoom-us
    #skypeforlinux
    #teams
    #viber
  ];
}
