{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     #lessc
     #sass

     nodejs
     #watchman
     #phantomjs2

     yarn

     ws

     nodePackages.node2nix
     yarn2nix
   ];

   home-manager.users.kirill = {
     home.file.".npmrc".source = ./dotfiles/npm/npmrc;
   };
}
