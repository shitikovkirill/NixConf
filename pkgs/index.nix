{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      htop
      zip
      unzip

      alsaTools
      thunderbird
      lsof
    ];

    imports = [
      #./social.nix
      ./browser.nix
    ];
}
