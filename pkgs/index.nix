{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      pass

      htop
      zip
      unzip

      lastpass-cli
      
      youtube-dl
    ];

    imports = [
      ./social.nix
      ./browser.nix
    ];
}
