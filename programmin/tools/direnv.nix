 
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv
  ];
  
  home-manager.users.kirill = {
    home.file.".direnvrc".source = ./dotfiles/direnv/direnvrc;
  };
}
