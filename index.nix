{pkgs, prefix, ... }:
let
  secrets = import ./load-secrets.nix;
  shared = import ./shared.nix;
in
{
  time.timeZone = "Europe/Kiev";
  nixpkgs.config.allowUnfree = true;

  imports = [
  "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
  ./users.nix
  ./envvar.nix
  ./network.nix
  ./pkgs/index.nix
  ./graphical/kde.nix
  ./devises/audio.nix
  ./devises/video.nix
  ./tools/zsh.nix
  ./programmin/index.nix
  ./containers/index.nix
  ];

  environment.interactiveShellInit = ''
    alias clear_nixp='sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && sudo nix-collect-garbage -d'
  '';
}
