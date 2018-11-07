{
  gitlab = ({ config = import ./gitlab.nix; }) // { autoStart=true; };
}
