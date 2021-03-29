{ config, pkgs, ... }:

let
  hInit = ''
    eval "$(h --setup ~/Programming)"
  '';
in {
  programs.bash.enableCompletion = true;

  nix = { package = pkgs.nixUnstable; };

  environment.systemPackages = with pkgs; [
    niv
    nox
    nix-info
    nix-index
    nixfmt
    nix-prefetch-git
    # nixops
    nixFlakes

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
  programs.bash.interactiveShellInit = hInit;
}
