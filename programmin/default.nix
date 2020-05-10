{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnumake

    #heroku

    ngrok
  ];

  imports = [
    ./tools
    #./server.nix
    #./go.nix
    #./python.nix
    #./php.nix
  ];
}
