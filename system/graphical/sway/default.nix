{ config, lib, pkgs, ... }:

let i3blocks-contrib = import ./pkgs/i3blocks-contrib.nix { pkgs = pkgs; };
in {
  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "sway";
      autoLogin = {
        enable = true;
        user = "kirill";
      };
    };
  };

  programs.sway = {
    enable = true;

    wrapperFeatures = {
      # Fixes GTK applications under Sway
      gtk = true;
      # To run Sway with dbus-run-session
      base = true;
    };

    extraPackages = with pkgs; [
      alacritty
      xfce.thunar

      dmenu
      rofi
      xwayland

      brightnessctl
      lm_sensors

      swayidle
      swaylock
      swaybg

      xkb-switch

      i3blocks
      i3status

      gebaar-libinput # libinput gestures utility

      grim
      slurp
      wf-recorder # wayland screenrecorder

      waybar
      mako
      volnoti
      kanshi
      wl-clipboard
      wdisplays

      wofi
      xfce.xfce4-appfinder

      # TODO: more steps required to use this?
      xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots

      jq
    ];

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
      # Fix "Firefox is already running, but not responding. To open..."
      export MOZ_DBUS_REMOTE=1
      export XDG_CURRENT_DESKTOP=sway
      export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
      systemctl --user import-environment
    '';
  };
  security.pam.services.swaylock = { };

  environment = {
    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      "sway/config".source = ./dotfiles/sway/config;
      "xdg/i3blocks/config".source = ./dotfiles/i3blocks/config;
      "xdg/i3blocks/blocks".source = i3blocks-contrib;
      "xdg/i3blocks/brightness".source = ./dotfiles/i3blocks/brightness;
      "xdg/waybar".source = ./dotfiles/waybar;
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    iw
    acpi
    xkb-switch
    networkmanager_dmenu
    blueberry
    xfce.thunar
    jq
    sysstat
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };

  programs.waybar.enable = true;
  services.pipewire.enable = true;

  fonts.fonts = with pkgs; [ font-awesome source-code-pro iosevka ];

  home-manager.users.kirill = {
    home = {
      #stateVersion = "22.11";
      file.".config/alacritty/alacritty.yml".source =
      ./dotfiles/alacritty.yml;
    };
  };
}
