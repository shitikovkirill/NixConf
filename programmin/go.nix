{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ go 	golint dep mod ];

  environment.variables = {
    #GOROOT = "${pkgs.go.out}/share/go";
    GOPATH = "$HOME/.local/share/go";
  };
  environment.interactiveShellInit = ''
    mkdir -p $HOME/.local/share/go
  '';

  programs.zsh = {
    ohMyZsh = {
      plugins = [ "golang" ];
    };
  };
}
