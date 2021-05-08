{ config, pkgs, ... }:

{

  imports = [
    ./git.nix
    ./docker.nix
    ./ide.nix
    ./vagrant.nix
    # ./vagga.nix
    ./bash.nix
    ./cloud.nix
    ./direnv.nix
    ./nix-tools.nix
    ./arduino.nix
    #./devpi.nix
  ];
}
