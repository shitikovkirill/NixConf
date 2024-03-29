{ config, pkgs, ... }: {
  # Xfce
  services.xserver = {
    enable = true;
    desktopManager = { xfce.enable = true; };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "kirill";
      };
      lightdm = { enable = true; };
    };
  };
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-dropbox-plugin
    thunar-volman
  ];
  networking.networkmanager.enable = true;
  hardware.acpilight.enable = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    plano-theme
    xorg.xbacklight
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.thunar-archive-plugin
    xfce.garcon
    xfce.exo
    xfce.libxfce4ui
    xfce.ristretto
    xfce.parole
    xfce.xfce4-battery-plugin
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpufreq-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-datetime-plugin
    xfce.xfce4-dev-tools
  ];
}
