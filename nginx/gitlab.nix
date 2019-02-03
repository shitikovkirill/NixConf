{ config, pkgs, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."gitlab.comp" = {
      enableACME = false;
      forceSSL = false;
      #listen.port = 8080;
      locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
    };
  };
}
