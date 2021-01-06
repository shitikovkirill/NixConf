{ config, pkgs, ... }:

{
  programs.bash.enableCompletion = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    atom
    #brackets
    vscode
    #soapui
    postman
  ];

  imports = [ ./jetbrains.nix ];
}
