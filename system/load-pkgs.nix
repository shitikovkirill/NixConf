if builtins.pathExists ./local/pkgs.nix then
  import ./local/pkgs.nix
else
  { pkgs, prefix, ... }: { }
