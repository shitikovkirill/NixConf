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

      keeweb
      openlogviewer
      stacker
    ];

    imports = [
      ./social.nix
      ./browser.nix
      ./office.nix
    ];

    nixpkgs.config.packageOverrides = super: {
        keeweb = pkgs.callPackage ./custom/KeeWeb {};
        openlogviewer = pkgs.callPackage ./custom/Logger {};
        stacker = pkgs.callPackage ./custom/Stacker {};
    };
}
