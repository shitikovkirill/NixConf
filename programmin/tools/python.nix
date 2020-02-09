{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ winpdb ];

  programs.bash.shellAliases = {
    d_jupiter = "docker run -p 8888:8888 jupyter/scipy-notebook";
    d_superset = "docker run -p 8088:8088 tylerfowler/superset";
  };
}
