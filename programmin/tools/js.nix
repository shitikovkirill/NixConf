{ config, pkgs, ... }:

let
initNvm = ''
  export NVM_DIR="$([ -z "$XDG_CONFIG_HOME" ] && printf %s "$HOME/.nvm" || printf %s "$XDG_CONFIG_HOME/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  '';
in {
  environment.systemPackages = with pkgs; [
    #lessc
    #sass

    nodejs
    #watchman
    #phantomjs2

    yarn

    ws
  ];

  ### Need for install global pacages to custom dir
  #home-manager.users.kirill = {
  #  home.file.".npmrc".source = ./dotfiles/npm/npmrc;
  #};
  #environment.variables = {
  #  PATH = "~/.npm-packages/bin:$PATH";
  #};
  programs.bash.shellInit = initNvm;
}
