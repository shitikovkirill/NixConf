{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    docker
    python36Packages.docker_compose
    docker-machine
  ];

  virtualisation.docker.enable = true;
  users.users.kirill.extraGroups = [ "docker" ];

  environment.interactiveShellInit = ''
    alias drcont='docker rm $(docker ps -a -q)'
    alias drimage='docker rmi $(docker images -q)'
  '';
 }
