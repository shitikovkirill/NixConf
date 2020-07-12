{ config, pkgs, ... }:

let
  hInit = ''
    eval "$(h --setup ~/Programming)"
  '';
in {
  programs.bash.enableCompletion = true;

  environment.systemPackages = with pkgs; [
    nox
    nix-info
    nix-index
    nixfmt
    nix-prefetch-git

    (pkgs.vim_configurable.customize {
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix ]; # load plugin on startup
      };
    })

    h
  ];

  services.lorri.enable = true;
  programs.zsh.shellInit = hInit;
  programs.bash.shellInit = hInit;
}
