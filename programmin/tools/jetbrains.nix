{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.jdk
    jetbrains.pycharm-professional
    jetbrains.datagrip
    jetbrains.goland
    jetbrains.phpstorm
    jetbrains.webstorm
    jetbrains.ruby-mine
  ];
}
