{ config, pkgs, ... }:

{
  services = {
    jenkins = {
      enable = true;
      port = 8888;
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
