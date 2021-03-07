{
  system.stateVersion = "unstable";

  nixpkgs.config.permittedInsecurePackages = [ "libvirt-5.9.0" ];

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
