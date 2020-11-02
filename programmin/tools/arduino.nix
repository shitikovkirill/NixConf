{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ arduino arduino-cli ];
}
