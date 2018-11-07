{ config, pkgs, ... }:

{
   programs.bash.enableCompletion = true;

   environment.systemPackages = with pkgs; [
     atom
   ];
}
