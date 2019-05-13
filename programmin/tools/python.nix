{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      python36Full

      pypi2nix

      python36Packages.virtualenv
   ];
   
    programs.bash.shellAliases = {
        d_jupiter = "docker run -d -p 8888:8888 jupiter/scipy-notebook";
        d_superset = "docker run -d -p 8088:8088 tylerfowler/superset";
    };
}
