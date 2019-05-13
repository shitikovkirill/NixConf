{
  programs.bash.shellAliases = {
    clear_trach = "rm -rf ~/.local/share/Trash";
    clear_nixp = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old && nix-collect-garbage -d && sudo nix-collect-garbage -d";
    fix_own = "sudo chown -R $(id -un):$(id -gn)";
    find_from_current_folder = "grep -rni $(pwd) -e ";
  };
}
