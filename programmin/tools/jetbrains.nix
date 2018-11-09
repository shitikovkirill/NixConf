{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     openjdk10
     jetbrains.jdk
     jetbrains.pycharm-professional
     jetbrains.datagrip
     jetbrains.goland
     jetbrains.phpstorm
     jetbrains.webstorm
     jetbrains.ruby-mine
   ];
}
