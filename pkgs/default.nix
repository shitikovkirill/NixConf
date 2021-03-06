{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pass

    htop
    zip
    unzip

    lastpass-cli

    tixati

    dropbox-cli

    #unetbootin
  ];

  imports = [ ./social.nix ./browser.nix ./office.nix ];
}
