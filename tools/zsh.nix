{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "agnoster";
    };
  };
}
