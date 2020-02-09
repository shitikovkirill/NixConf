{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    direnv
  ];
  
  programs = {
    bash.shellInit = ''
        if [ -x "$(command -v direnv)" ]; then
            eval "$(direnv hook bash)"
        fi
    '';
    zsh = lib.mkIf (config.programs.zsh.enable) {
    shellInit = ''
        if [ -x "$(command -v direnv)" ]; then
            eval "$(direnv hook zsh)"
        fi
    '';
    };
  };
  
  home-manager.users.kirill = {
    home.file.".direnvrc".source = ./dotfiles/direnv/direnvrc;
  };
}
