{
  environment.shellAliases = {
    clear_trash = "MYHOME=$HOME && sudo rm -rf $MYHOME/.local/share/Trash";
    clear_nixp =
      "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && sudo nix-collect-garbage -d";
    clear_dns = "sudo nscd -i hosts";
    fix_own = "sudo chown -R $(id -un):$(id -gn)";
    find_from_current_folder = "grep -rni $(pwd) -e ";
    nixfmt_this = "find . -print -name '*.nix' -exec nixfmt {} \;"
  };
}
