{ config, lib, pkgs, ... }:

{
  users.users = {
    kirill = {
      isNormalUser = true;
      home = "/home/nixos";
      description = "Kirill Shitikov";
      # shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "audio" "dialout" ];
    };
  };

}

