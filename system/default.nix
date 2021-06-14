{
  system.stateVersion = "unstable";

  nixpkgs.config.permittedInsecurePackages = [ "libvirt-5.9.0" "python2.7-Pillow-6.2.2" ];
  nixpkgs.config.allowBroken = true;
  programs.dconf.enable = true;

  imports = [
    ./sudoers.nix
    ./users.nix
    ./envvar.nix
    ./aliases.nix
    ./network.nix
    ./graphical/load-graphic.nix
    ./devises
    # ./kvm.nix
  ];
}
