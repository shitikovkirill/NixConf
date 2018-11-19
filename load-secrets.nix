if builtins.pathExists ./secrets.nix then import ./secrets.nix else {
  github_token = "";
}
