{
  system.stateVersion = "unstable";

  imports = [
    ./sudoers.nix
    ./users.nix
    ./envvar.nix
    ./aliases.nix
    ./network.nix
    ./graphical/load-graphic.nix
    ./devises
    ./kvm.nix
  ];
}
