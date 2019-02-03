{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
	kubectl
   ];

   services.kubernetes = {
     verbose = true;
     roles = ["master" "node"];
   };

   networking.firewall.allowedTCPPorts = [ 
        8080
   ];  
}
