{
  system.stateVersion = "unstable";

  nixpkgs.config.permittedInsecurePackages =
    [ "electron-12.2.3" ];
  # nixpkgs.config.allowBroken = true;
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
