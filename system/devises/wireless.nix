{ config, pkgs, ... }: {
  networking.wireless.enable = true;
  networking.wireless.networks = { TP-LINK_folnet = { psk = "23072011"; }; };
}
