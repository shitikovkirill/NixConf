{ config, pkgs, ... }:

{
  services = {
    jenkins = {
      enable = true;
      listenAddress = "localhost";
      user = "root";
      extraGroups = [ "wheel" "docker" ];
      packages = with pkgs; [
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

  environment.shellAliases = {
    drcont = "docker rm $(docker ps -a -q)";
    drimage = "docker rmi $(docker images -q)";
    drvolume = "docker volume rm $(docker volume ls -q --filter dangling=true)";
    dcstop = "docker stop $(docker ps -aq)";
    clear_nixp =
      "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && sudo nix-collect-garbage -d";
  };

  environment.systemPackages = with pkgs; [
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

  environment.variables.PATH = "~/.config/composer/vendor/bin/:$PATH";

}
