{pkgs, prefix, ... }:

{
  imports = [
    ./video.nix
    ./wireless.nix
  ];
}
