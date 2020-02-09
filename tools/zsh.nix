{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    histSize = 5000;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
    };
  };
}
