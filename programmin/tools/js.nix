{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #lessc
    #sass

    nodejs
    #watchman
    #phantomjs2

    yarn

    #ws
  ];

  ### Need for install global pacages to custom dir
  home-manager.users.kirill = {
    home.file.".npmrc".source = ./dotfiles/npm/npmrc;
  };
}
