if builtins.pathExists ./local/containers.nix then
  import ./local/containers.nix
else
  { }
