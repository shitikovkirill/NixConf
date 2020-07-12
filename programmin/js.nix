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

  programs.zsh = { ohMyZsh = { plugins = [ "yarn" ]; }; };

  ### Need for install global pacages to custom dir
  home-manager.users.kirill = {
    home.file.".npmrc".source = ./tools/dotfiles/npm/npmrc;
  };
}
