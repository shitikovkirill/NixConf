{
  system.stateVersion = "unstable";

  nix.extraOptions = ''
    experimental-features = nix-command
  '';

  nixpkgs.config.permittedInsecurePackages =
    [ "electron-19.1.9" "openssl-1.1.1u" "openssl-1.1.1w" ];
  # nixpkgs.config.allowBroken = true;
  programs.dconf.enable = true;

  imports = [
    ./sudoers.nix
    ./users.nix
    ./envvar.nix
    ./aliases.nix
    ./network.nix
    ./graphical/load-graphic.nix
    ./load-pkgs.nix
    ./devises
    # ./kvm.nix
  ];
}
