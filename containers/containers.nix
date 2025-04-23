{
  #containers.telegram = {
  #  autoStart = true;
  #  privateNetwork = true;
  #  hostAddress = "192.168.100.10";
  #  localAddress = "192.168.100.11";
  #  config = { config, pkgs, lib, ... }: {
  #    imports = [ ./telegram ];
  #
  #    security.acme = {
  #      defaults.email = "sh.kiruh@gmail.com";
  #      acceptTerms = true;
  #    };
  #  };
  #};
}
