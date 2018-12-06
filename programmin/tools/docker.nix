{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    docker
    python36Packages.docker_compose
    docker-machine

    kubectl

    google-cloud-sdk
    awscli
  ];

  virtualisation.docker.enable = true;
  users.users.kirill.extraGroups = [ "docker" ];

  environment.interactiveShellInit = ''
    alias drcont='docker rm $(docker ps -a -q)'
    alias drimage='docker rmi $(docker images -q)'
    alias drvolume='docker volume rm $(docker volume ls -q --filter dangling=true)'
    alias dcstop='docker stop $(docker ps -aq)'
  '';
 }
