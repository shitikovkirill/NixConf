{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnumake

    #heroku

    ngrok
  ];

  imports = [
    ./tools
    ./bash.nix
    #./go.nix
    ./python
    ./js.nix
    ./raspberry.nix
    #./php.nix
  ];
}
