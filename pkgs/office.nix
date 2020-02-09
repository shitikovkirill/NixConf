{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ marp ];
}

