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
    ];

    imports = [
      ./social.nix
      ./browser.nix
      ./office.nix
    ];
    
    nixpkgs.config.packageOverrides = super: {
       keeweb = pkgs.callPackage ./custom/KeeWeb {};
    };
}
