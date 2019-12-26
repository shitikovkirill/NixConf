{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      htop
      zip
      unzip
    ];
   
    imports = [
      ./browser.nix
    ];
}
