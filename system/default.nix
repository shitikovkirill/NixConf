{
  system.stateVersion = "unstable";

  imports = [
    ./sudoers.nix
    ./users.nix
    ./envvar.nix
    ./aliases.nix
    ./network.nix
    ./graphical/sway
    ./devises
    # ./kvm.nix
  ];
}
