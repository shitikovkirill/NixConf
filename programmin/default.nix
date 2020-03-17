{ config, pkgs, ... }:

{
   imports = [
     ./recipes
     ./tools
     ./rabbitmq.nix
   ];
}
