{
  system.stateVersion = "unstable";

  imports = [
    ./sudoers.nix
    ./users.nix
    ./envvar.nix
    ./aliases.nix
    ./network.nix
    ./graphical/kde.nix
    ./devises
    # ./kvm.nix
  ];
}
