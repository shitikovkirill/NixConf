{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    disabledPlugins = [ "sap" ];
    # sudo rfkill unblock bluetooth
  };
  hardware.pulseaudio = { package = pkgs.pulseaudioFull; };
}
