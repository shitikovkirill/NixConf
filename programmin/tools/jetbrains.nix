{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     openjdk10
     jetbrains.jdk
     jetbrains.pycharm-community
   ];
}
