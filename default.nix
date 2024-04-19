{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
    ./tools
    ./system
    ./pkgs
    ./development
    ./containers
    ./services
  ];

  nixpkgs.config.allowUnfree = true;
  home-manager.users.kirill.home.stateVersion = "23.11";
}
