{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    python36Packages.docker_compose

    kubectl
  ];

  virtualisation.docker.enable = true;
  users.users.kirill.extraGroups = [ "docker" ];

  services.kubernetes = {
    roles = [ "master" "node" ];
    kubeconfig.server = "http://0.0.0.0:8080";
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];

  programs.bash.shellAliases = {
    drcont = "docker rm $(docker ps -a -q)";
    drimage = "docker rmi $(docker images -q)";
    drvolume = "docker volume rm $(docker volume ls -q --filter dangling=true)";
    dcstop = "docker stop $(docker ps -aq)";
  };
}
