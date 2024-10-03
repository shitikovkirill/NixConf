{ config, pkgs, ... }:
{
  imports = [
      ./load-containers.nix
    ];

  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "wlp3s0";
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
}



