{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnumake

    #heroku

    ngrok
  ];

  imports = [
    ./tools
    ./go.nix
    ./python.nix
    ./js.nix
    #./php.nix
  ];
}
