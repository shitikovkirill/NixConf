{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gitg
    git-cola
    git
    git-crypt
    gitAndTools.gitFull
    gitAndTools.pre-commit
  ];

  home-manager.users.kirill = {
    home.file.".gitconfig".source = ./dotfiles/git/gitconfig;
    home.file.".gitignore".source = ./dotfiles/git/gitignore;

    programs.git = {
      enable = true;
      userName = "Shitikov Kirill";
      userEmail = "k.shitikov@itransition.com";
      extraConfig = {
        push = { default = "current"; };
        apply = { whitespace = "nowarn"; };
        core = { autocrlf = "input"; };
      };
    };
  };

  programs.zsh = { ohMyZsh = { plugins = [ "git" "gitignore" ]; }; };

  environment.shellAliases = {
    git-show-local-merged-b =
      "git branch --merged | grep -v master | grep -v develop";
    git-show-remote-merged-b =
      "git branch -r --merged | grep -v master | grep -v develop";

    git-remove-local-merged-b =
      "git branch --merged | grep -v master | grep -v develop | xargs git branch -d";

    git-fix-conflict =
      "git diff --name-only --diff-filter=U | uniq  | xargs $EDITOR";
  };
}
