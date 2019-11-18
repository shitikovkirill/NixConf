{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    google-cloud-sdk
    
    # AWS
    awscli
    aws-sam-cli
    
    #terraform
    #terraform-docs
    #terraform-providers.aws
    #terraform-providers.kubernetes
    
    cloudflared
  ];
 }
