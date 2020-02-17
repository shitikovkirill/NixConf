{ config, pkgs, ... }:

{
  imports = [
    ./gitlab.nix
    ./prometheus.nix
    ./pgmanage.nix
    ./mailcatcher.nix
    ./mail.nix
    ./sentry.nix
  ];
}
