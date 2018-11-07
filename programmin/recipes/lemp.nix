{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
      php
      mariadb
      nginx
   ];

services.nginx = {
  enable = true;
  virtualHosts."blog.example.com" = {
    enableACME = false;
    forceSSL = false;
    root = "/var/www/blog";
    locations."~ \.php$".extraConfig = ''
      fastcgi_pass 127.0.0.1:9072;
      fastcgi_index index.php;
    '';
  };
};
services.mysql = {
  enable = true;
  package = pkgs.mariadb;
};
services.phpfpm.poolConfigs.mypool = ''
  listen = 127.0.0.1:9072
  user = nobody
  pm = dynamic
  pm.max_children = 5
  pm.start_servers = 2 
  pm.min_spare_servers = 1 
  pm.max_spare_servers = 3
  pm.max_requests = 500
'';
}