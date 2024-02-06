{ config, pkgs, ... }:

let
  hInit = ''
    eval "$(h --setup ~/Development)"
  '';
in {
  environment.systemPackages = with pkgs; [ h ];

  programs.zsh.shellInit = hInit;
  programs.bash.interactiveShellInit = hInit;
}
