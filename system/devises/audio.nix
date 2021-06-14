{ config, pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    zeroconf.discovery.enable = true;
  };

  services.avahi = {
    enable = true;
  };
}
