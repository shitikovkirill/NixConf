if builtins.pathExists ./secrets.nix then import ./secrets.nix else {
  smtp_username = "";
  smtp_password = "";
}
