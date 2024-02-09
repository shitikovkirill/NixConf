{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/Prague";

  imports = [ ./aliases.nix ./users.nix ./boot-loader.nix ./devises ./network ];
}

