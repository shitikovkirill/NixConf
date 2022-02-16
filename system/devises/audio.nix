{ config, pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    zeroconf.discovery.enable = true;
  };

  #services.avahi = { enable = true; };

  #networking = { firewall = { allowedTCPPorts = [ 4317 ]; }; };
}
