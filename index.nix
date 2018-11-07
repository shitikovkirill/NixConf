{pkgs, prefix, ... }:

{
  time.timeZone = "Europe/Kiev";

  imports = [
  "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
  ./pkgs.nix
  ./graphical/kde.nix
  ./devises/audio.nix
  ./users.nix
  ./network.nix
  ./tools/zsh.nix
  ./programmin/index.nix
  ];
}
