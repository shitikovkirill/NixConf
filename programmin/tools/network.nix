{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ wireshark charles3 ];
}
