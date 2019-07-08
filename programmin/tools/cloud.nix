{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    google-cloud-sdk
    
    # AWS
    awscli
    aws-sam-cli
  ];
 }
