{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ go golint dep mod ];

  programs.zsh = { ohMyZsh = { plugins = [ "golang" ]; }; };
}
