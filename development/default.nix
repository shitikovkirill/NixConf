{ config, lib, pkgs, ... }:

{
  imports = [
    ./ide.nix
    ./git
    ./direnv
    ./nix
    ./h
    ./docker.nix
    ./python
    ./go.nix
    ./database
    ./electronics.nix
  ];
}

