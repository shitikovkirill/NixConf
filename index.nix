{pkgs, prefix, ... }:

{
  time.timeZone = "Europe/Kiev";

  imports = [
  "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-19.03.tar.gz}/nixos"
  ./pkgs/index.nix
  ./system/index.nix
  ./programmin/index.nix
  ./devises/index.nix
  ];
}
