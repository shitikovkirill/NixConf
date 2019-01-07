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

  programs.bash.shellAliases = {
    drcont   = "docker rm $(docker ps -a -q)";
    drimage  = "docker rmi $(docker images -q)";
    drvolume = "docker volume rm $(docker volume ls -q --filter dangling=true)";
    dcstop   = "docker stop $(docker ps -aq)";
    dlint    = "docker run --rm -i hadolint/hadolint";
    dlint-deb = "docker run -v $(pwd):/app:ro --workdir=/app --rm -i hadolint/hadolint:latest-debian hadolint";
  };
 }
