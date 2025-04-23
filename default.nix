{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/refs/heads/release-24.11.tar.gz";
in {
  imports = [
    (import "${home-manager}/nixos")
    ./tools
    ./system
    ./pkgs
    ./development
    ./containers
  ];

  nixpkgs.config.allowUnfree = true;
  home-manager.users.kirill.home.stateVersion = "23.11";
}
