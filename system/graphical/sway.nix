{ config, lib, pkgs, ... }:

{
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
      xwayland

      brightnessctl

      swayidle
      swaylock
      swaybg

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

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    gtkUsePortal = true;
  };
  services.pipewire.enable = true;
}
