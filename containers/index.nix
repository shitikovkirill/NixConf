{
  #gitlab = ({ config = import ./gitlab.nix; }) // { autoStart=true; };
  kub = { config = import ./kub.nix; };
}
