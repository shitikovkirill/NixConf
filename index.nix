{pkgs, prefix, ... }:

{
  system.autoUpgrade.enable = false;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-19.09;
  time.timeZone = "Europe/Kiev";

  imports = [
    "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-19.03.tar.gz}/nixos"
    ./pkgs
    ./system
    ./programmin
    #./devises
  ];
}
