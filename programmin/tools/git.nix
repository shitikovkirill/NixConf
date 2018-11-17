{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gitAndTools.gitFull
  ];
  home-manager.users.kirill = {
    home.file.".gitconfig".source = ./dotfiles/git/gitconfig;
    home.file.".gitignore".source = ./dotfiles/git/gitignore;

    programs.git = {
      enable = true;
      userName = "Shitikov Kirill";
      userEmail = "sh.kiruh@gmail.com";
      extraConfig = {
        push = { default = "current"; };
        apply = { whitespace = "nowarn"; };
        core = { autocrlf = "input"; };
      };
    };
  };
}
