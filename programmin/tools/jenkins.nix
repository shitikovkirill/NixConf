{ config, pkgs, ... }:

{
  services = {
    jenkins = {
      enable = true;
      port = 8888;
      listenAddress="0.0.0.0";
      user = "root";
      extraGroups = [ "wheel" "docker" ];
      packages = with pkgs; 
        [ 
        wget        

        git
        gnumake

        docker
        python36Packages.docker_compose
        docker-machine

        kubectl

        google-cloud-sdk
        awscli 
        ];
    };
  };


  virtualisation.docker.enable = true;

  environment.interactiveShellInit = ''
    alias drcont='docker rm $(docker ps -a -q)'
    alias drimage='docker rmi $(docker images -q)'
    alias drvolume='docker volume rm $(docker volume ls -q --filter dangling=true)'
    alias dcstop='docker stop $(docker ps -aq)'
    alias clear_nixp='sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && sudo nix-collect-garbage -d'
  '';

  environment.systemPackages = with pkgs;
  [
    wget
    php
    php72Packages.composer

    gnumake
    git

    docker
    python36Packages.docker_compose
    docker-machine

    kubectl

    google-cloud-sdk
    awscli
  ];

 }
