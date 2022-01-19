{ config, lib, pkgs, ... }:

with lib;

{
  # Provide networkmanager for easy wireless configuration.
  networking.networkmanager.enable = true;
  networking.wireless.enable = mkForce false;

  # Enter keyboard layout
  services.xserver.layout = "us,ru";

  # KDE complains if power management is disabled (to be precise, if
  # there is no power management backend such as upower).
  powerManagement.enable = true;
}
