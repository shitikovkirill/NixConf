{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      firefox
      chromium
      w3m

      pass

      htop
      zip
      unzip

      lastpass-cli
    ];
}
