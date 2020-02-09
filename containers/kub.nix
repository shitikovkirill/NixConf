{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ docker kubectl ];

  virtualisation.docker.enable = true;

  services.kubernetes = {
    roles = [ "master" "node" ];
    kubelet.extraOpts = "--fail-swap-on=false";
  };
}
