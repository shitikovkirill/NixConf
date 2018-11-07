{ config, pkgs, ... }:

{
   programs.bash.enableCompletion = true;

   environment.systemPackages = with pkgs; [
      nox
      nix-info

      (pkgs.vim_configurable.customize {
        name = "vim";
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ vim-nix ]; # load plugin on startup
        };
      })
   ];
}
