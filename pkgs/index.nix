{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      pass

      htop
      zip
      unzip

      lastpass-cli
      
      youtube-dl
      
      anydesk
    ];

    imports = [
      ./social.nix
      ./browser.nix
      ./office.nix
    ];
}
