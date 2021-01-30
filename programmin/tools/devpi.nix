{ config, pkgs, ... }:

{
  home-manager.users.kirill = {
    home.file.".pip/pip.conf".source = ./dotfiles/pip/pip.conf;
  };
}
