{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      pass

      htop
      zip
      unzip

      lastpass-cli
    ];

    imports = [
      ./social.nix
      ./browser.nix
    ];
}
