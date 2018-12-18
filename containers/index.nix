let
  localcontainers = import ./load-containers.nix;
in
{
  containers = ({
    #gitlab = ({ config = import ./gitlab.nix; autoStart=true; });
    #kub = { config = import ./kub.nix; };
    #jenkins = {
    #  autoStart=false;
    #  privateNetwork = false;
    #  hostAddress = "192.168.100.100";
    #  localAddress = "192.168.100.120";
    #  config = import ./jenkins.nix;
    #};
  }) // localcontainers;
}
