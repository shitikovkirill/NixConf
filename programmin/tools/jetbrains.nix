{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.pycharm-professional
    jetbrains.datagrip
    jetbrains.goland
    jetbrains.phpstorm
    jetbrains.webstorm
  ];
}
