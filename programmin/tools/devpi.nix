{ config, pkgs, ... }:

{
  home-manager.users.kirill = {
    home = {
      #stateVersion = "22.11";
      file.".pip/pip.conf".source = ./dotfiles/pip/pip.conf;
    };
  };
}
