{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    zip
    unzip
    # anydesk

    #lastpass-cli

    #tixati

    #dropbox-cli

    #unetbootin
  ];

  imports = [ ./social.nix ./browser.nix ];
}
