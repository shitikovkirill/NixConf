{ config, lib, pkgs, ... }:

{
  imports = [
    ./tools
    ./ide.nix
    ./git
    ./direnv
    ./nix
    ./h
    ./docker.nix
    ./python
    ./database
    ./electronics.nix
    ./bash.nix
  ];
}

