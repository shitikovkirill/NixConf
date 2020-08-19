{
  system.stateVersion = "unstable";

  imports = [
    ./sudoers.nix
    ./users.nix
    ./envvar.nix
    ./aliases.nix
    ./network.nix
    ./graphical/xfce.nix
    ./devises
    # ./kvm.nix
  ];
}
