{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ go golint dep mod ];

  programs.zsh = { ohMyZsh = { plugins = [ "golang" ]; }; };

  environment.variables = { GOPATH = "$HOME/.local/share/go"; };
  environment.interactiveShellInit = ''
    mkdir -p $HOME/.local/share/go/{src,bin,pkg}
  '';
}
