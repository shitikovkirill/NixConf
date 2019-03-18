{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    docker
    #ctop
    python36Packages.docker_compose
    docker-machine

    minikube
    kubectl

    google-cloud-sdk
    awscli
  ];

  virtualisation.docker.enable = true;
  users.users.kirill.extraGroups = [ "docker" ];

  programs.bash.shellAliases = {
    drcont     = "docker rm $(docker ps -a -q)";
    drimage    = "docker rmi $(docker images -q)";
    drvolume   = "docker volume rm $(docker volume ls -q --filter dangling=true)";
    dcstop     = "docker stop $(docker ps -aq)";
    dnorestart = "docker update --restart=no $(docker ps -aq)";
    dhist      = "docker history --no-trunc";
    dlint      = "docker run --rm -i hadolint/hadolint";
    dlint-deb  = "docker run -v $(pwd):/app:ro --workdir=/app --rm -i hadolint/hadolint:latest-debian hadolint";
    
    mk_start   = "sudo minikube start";
    mk_con     = "eval $(sudo minikube docker-env)";
    mk_ip      = "sudo minikube ip";
    mk_dash    = "sudo minikube dashboard";

  };
 }
