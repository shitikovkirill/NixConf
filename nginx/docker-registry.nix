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
        "registry.comp" = proxy 5000 // { default = true; };
      };
    };
  };
}
