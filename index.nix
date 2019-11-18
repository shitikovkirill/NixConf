{pkgs, prefix, ... }:
let
  secrets = import ./load-secrets.nix;
  shared = import ./shared.nix;
in
{
  time.timeZone = "Europe/Kiev";
  nixpkgs.config.allowUnfree = true;
  #system.autoUpgrade.enable = true;

  imports = [
  "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-19.03.tar.gz}/nixos"
  ./system/index.nix
  ./pkgs/index.nix
  ./tools/zsh.nix
  ./tools/translate.nix
  ./programmin/index.nix
  ./containers/index.nix
  ];
}
