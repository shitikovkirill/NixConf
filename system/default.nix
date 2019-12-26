{pkgs, prefix, ... }:

{
  imports = [
  ./users.nix
  ./network.nix
  ./aliases.nix
  ];
}
