{ config, lib, pkgs, ... }:

{
  imports = [ ./aliases.nix ./users.nix ./boot-loader.nix ./devises ./network ];
}

