{ config, lib, pkgs, ... }:

with lib;

{
  imports = [ ./graphical-base.nix ];

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
    };
    desktopManager.plasma5 = {
      enable = true;
      enableQt4Support = true;
    };

    # Enable touchpad support for many laptops.
    synaptics.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ark
    kdeApplications.baloo-widgets
    kdeApplications.dolphin-plugins
    kdeApplications.grantleetheme
    kdeApplications.kalarm
    kdeApplications.kalarmcal
    kdeApplications.kget
    kdeApplications.kmail
    kdeApplications.ksystemlog
    kdeApplications.krfb
    kdeApplications.okular
    kcachegrind
    ktorrent
    dragon
    filelight
    # Graphical text editor
    kate
  ];
}
