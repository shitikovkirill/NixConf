{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/Prague";

  imports = [ ./aliases.nix ./users.nix ./boot-loader.nix ./devises ./network ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-19.1.9" ];
}

