{ config, lib, pkgs, ... }:

{
  programs.bash.enableCompletion = true;
  environment.systemPackages = with pkgs; [ shellcheck ];
}
