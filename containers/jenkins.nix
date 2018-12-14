{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    docker
    python36Packages.docker_compose
    awscli
    git
  ];

  virtualisation.docker.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 ];

  services.jenkins = {
    enable = true;
    user = "root";
    extraGroups = [ "wheel" "docker" ];
    packages = [ pkgs.docker pkgs.python36Packages.docker_compose pkgs.awscli pkgs.git ];
    port = 80;
  };
 }
