{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    go

    golint
    golangci-lint

    dep
    mod

    compile-daemon

    gopls

    gotests
    gomodifytags

    gogetdoc
    go-symbols
    go-outline
    gopkgs
    reftools
  ];

  programs.zsh = { ohMyZsh = { plugins = [ "golang" ]; }; };

  environment.variables = { GOPATH = "$HOME/.local/share/go"; };
  environment.interactiveShellInit = ''
    mkdir -p $HOME/.local/share/go/{src,bin,pkg}
  '';
}
