{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    zip
    unzip

    arduino
    
    # anydesk

    #lastpass-cli

    #tixati

    #dropbox-cli

    #unetbootin
  ];

  imports = [ ./social.nix ./browser.nix ];
}
