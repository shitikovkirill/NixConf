{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     nodejs

     yarn
   ];
   
   home-manager.users.kirill = {
     home.file.".npmrc".source = ./dotfiles/npm/npmrc;
   };
}
