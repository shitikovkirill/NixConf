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

    videoDrivers = [  "intel" "nvidia" ];
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
    kdeApplications.spectacle
    kcachegrind
    ktorrent
    dragon
    filelight
    kdeconnect
    # Graphical text editor
    kate
  ];

  # reload icons in kde
  programs.bash.shellAliases = {
    kde_update = "rm ~/.cache/ksycoca5_* -rf && kbuildsycoca5";
  };
}