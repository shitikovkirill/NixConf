{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
      docker
      python36Packages.docker_compose      
   ];

   virtualisation.docker.enable = true;
   users.users.kirill.extraGroups = [ "docker" ];
   
   programs.bash.shellAliases = {
     drcont   = "docker rm $(docker ps -a -q)";
     drimage  = "docker rmi $(docker images -q)";
     drvolume = "docker volume rm $(docker volume ls -q --filter dangling=true)";
     dcstop   = "docker stop $(docker ps -aq)";
   };
}
