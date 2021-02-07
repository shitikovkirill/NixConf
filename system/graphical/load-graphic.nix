if builtins.pathExists ./secrets.nix then
  import ./secrets.nix
else
  { pkgs, prefix, ... }: { imports = [ ./sway ]; }
