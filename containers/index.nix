let
  localcontainers = import ./load-containers.nix;
in
{
  containers = ({
    #gitlab = ({ config = import ./gitlab.nix; autoStart=true; });
    kub = { config = import ./kub.nix; };
  }) // localcontainers;
}
