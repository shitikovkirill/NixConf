{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    #arion
    #ctop
    docker-compose
    docker-machine

    #minikube
    kubectl
    #kubernetes-helm
  ];

  virtualisation.docker.enable = true;
  users.users.kirill.extraGroups = [ "docker" ];

  environment.shellAliases = {
    drcont = "docker rm $(docker ps -a -q)";
    drimage = "docker rmi $(docker images -q)";
    drvolume = "docker volume rm $(docker volume ls -q --filter dangling=true)";
    drnetwork = "docker network prune";
    dcstop = "docker stop $(docker ps -aq)";
    dnorestart = "docker update --restart=no $(docker ps -aq)";
    dhist = "docker history --no-trunc";
    dlint = "docker run --rm -i hadolint/hadolint";
    dlint-deb =
      "docker run -v $(pwd):/app:ro --workdir=/app --rm -i hadolint/hadolint:latest-debian hadolint";
    dpoetry =
      "docker run -v $(pwd):/app --workdir=/app --rm -it etiennenapoleone/docker-python-poetry bash";

    mk_start = "sudo minikube start";
    mk_con = "eval $(sudo minikube docker-env)";
    mk_context = "sudo kubectl config use-context minikube";
    mk_ip = "sudo minikube ip";
    mk_dash = "sudo minikube dashboard";

  };
}
