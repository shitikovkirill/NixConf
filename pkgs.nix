{ lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
       firefox
       atom
       htop
       zip
       unzip
    ];
}
