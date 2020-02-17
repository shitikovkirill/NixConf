{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs;
   [
     gnumake
   ];

   imports = [
    ./recipes/sentry.nix
   ];
}
