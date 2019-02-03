{ config, pkgs, ... }:

{
  services = {
    nginx= {
      enable = true;

      virtualHosts = let
        base = locations: {
          inherit locations;

          forceSSL = false;
          enableACME = false;
        };
        proxy = port: base {
          "/".proxyPass = "http://127.0.0.1:" + toString(port) + "/";
        };
      in {
        "jenkins.comp" = proxy 8888 // { default = true; };
      };
    };
  };

  #security.acme.certs = {
  #  "jenkinx.comp".email = "sh.kiruh@gmail.com";
  #};
}
