{ config, pkgs, ... }:

{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];

  services = {
    nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = false;

      virtualHosts = let
        base = locations: {
          inherit locations;

          forceSSL = true;
          enableACME = true;
        };
        proxy = port:
          base { "/".proxyPass = "http://127.0.0.1:" + toString (port) + "/"; };
      in { "url" = proxy 8080 // { default = true; }; };
    };
  };

  security.acme.certs = { "url".email = "email"; };
}
