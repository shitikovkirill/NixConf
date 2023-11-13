{ config, pkgs, ... }:

{
  programs.bash.enableCompletion = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #brackets
    vscode
    #soapui
    #postman
    #jmeter
    dbeaver
  ];

  imports = [ ./jetbrains.nix ];
}
