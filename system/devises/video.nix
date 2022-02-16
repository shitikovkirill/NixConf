{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vokoscreen
    # vlc
    youtube-dl

    # pciutils
  ];

  # disable card with bbswitch by default
  # hardware.nvidiaOptimus.disable = true;
  # install nvidia drivers in addition to intel one
  hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
}
