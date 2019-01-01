{pkgs, prefix, ... }:

{
  imports = [
  ./system/users.nix
  ./system/network.nix
  ./system/aliases.nix
  ];
}
