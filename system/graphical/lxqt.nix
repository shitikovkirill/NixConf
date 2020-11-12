{ config, pkgs, ... }: {
  # LXQt
  services.xserver = {
    enable = true;
    desktopManager = { lxqt.enable = true; };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "kirill";
      };
      lightdm = { enable = true; };
    };
  };
  environment.lxqt.excludePackages = with pkgs.lxqt; [
    qterminal
    liblxqt
    qps
    lxqt-admin
    lxqt-themes
    lxqt-archiver
    lxqt-globalkeys
    lxqt-powermanagement
    lxqt-build-tools
    lxqt-panel
    lxqt-notificationd
  ];

  networking.networkmanager.enable = true;
  services.blueman.enable = true;
}
