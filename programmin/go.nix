{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ go dep ];

  environment.variables = {
    #GOROOT = "${pkgs.go.out}/share/go";
    GOPATH = "$HOME/.local/share/go";
  };
  environment.interactiveShellInit = ''
    mkdir -p $HOME/.local/share/go
  '';
}
