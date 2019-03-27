{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gitg
    git-cola
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
  
  programs.bash.shellAliases = {
    git-show-local-merged-b = "git branch --merged | grep -v master | grep -v develop";
    git-show-remote-merged-b = "git branch -r --merged | grep -v master | grep -v develop | sed \"s/origin\//:/\"";
    git-remove-local-merged-b = "git branch --merged | grep -v master | grep -v develop | xargs git branch -d";
    git-remove-remote-merged-b = "git branch -r --merged | grep -v master | grep -v develop | sed \"s/origin\//:/\" | xargs -n 1 git push origin";
  };
}
