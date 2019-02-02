{ config, pkgs, ... }:

{
services.openssh = {
	enable = true;	
};
networking.firewall.enable = false;

networking.extraHosts =
  ''
    127.0.0.1 git.example.com
  '';
}
