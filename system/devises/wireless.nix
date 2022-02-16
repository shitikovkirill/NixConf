{ config, pkgs, ... }: {
  networking.wireless.enable = true;
  networking.wireless.networks = { ASUS = { psk = "23072011"; }; };
}
