{pkgs, prefix, ... }:

{
  time.timeZone = "Europe/Kiev";

  imports = [
  "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
  ./pkgs/index.nix
  ./users.nix
  ./network.nix
  ./programmin/index.nix
  ];
}
