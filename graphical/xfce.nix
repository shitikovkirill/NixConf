{ config, pkgs, ... }:
{
  # Xfce
  services.xserver= {
    desktopManager = {
      xfce.enable = true;
      xfce.thunarPlugins = [ pkgs.xfce.thunar-archive-plugin ];
      default = "xfce";
    };
    displayManager.auto = {
      enable = false;
      user = "kirill";
    };
  };
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
      networkmanagerapplet
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-xkb-plugin
      xfce.thunar-archive-plugin
      plano-theme
   ];
}
