{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      firefox
      chromium
      w3m

      scudcloud

      pass

      htop
      zip
      unzip

      lastpass-cli
    ];
}
