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
    ./go.nix
    ./database
    ./electronics.nix
    ./bash.nix
  ];
}

