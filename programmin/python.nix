{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ python36 ];
}