{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    histSize = 10000;
    ohMyZsh = {
      enable = true;
      plugins =
        [ "man" "history" "systemd" "systemadmin" ];
      theme = "agnoster";
    };
  };
}
