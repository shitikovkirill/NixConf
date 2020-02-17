{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gnumake ];

  imports = [
    ./git.nix
    #./docker.nix
    ./ide.nix
  ];
}
