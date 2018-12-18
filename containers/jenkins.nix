{ config, pkgs, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  services = {
    nginx= {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = false;

      virtualHosts = let
        base = locations: {
          inherit locations;

          forceSSL = false;
          enableACME = false;
        };
        proxy = port: base {
          "/".proxyPass = "http://127.0.0.1:" + toString(port) + "/";
        };
      in {
        "ec2-35-159-10-125.eu-central-1.compute.amazonaws.com" = proxy 8080 // { default = true; };
      };
    };

    jenkins = {
      enable = true;
      listenAddress="localhost";
      user = "root";
      extraGroups = [ "wheel" "docker" ];
      packages = with pkgs;
        [
        git
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
    git
    docker
    python36Packages.docker_compose
    docker-machine

    kubectl

    google-cloud-sdk
    awscli
    gnumake
  ];

  #security.acme.certs = {
  #  "ec2-35-159-10-125.eu-central-1.compute.amazonaws.com".email = "sh.kiruh@gmail.com";
  #};
 }
