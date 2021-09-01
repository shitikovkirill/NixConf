{ pkgs, prefix, ... }:
let
  secrets = import ./load-secrets.nix;
  shared = import ./shared.nix;
in {
  time.timeZone = "Europe/Kiev";
  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
  };

  imports = [
    (import "${
        builtins.fetchTarball
        "https://github.com/nix-community/home-manager/archive/master.tar.gz"
      }/nixos")
    ./system
    ./pkgs
    ./tools
    ./programmin
    ./containers
  ];
}
