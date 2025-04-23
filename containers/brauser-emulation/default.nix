{ config, pkgs, lib, ... }:
let
  env = config.services.appConfig.env;
  #secrets = import (../../../secrets + builtins.toPath "/${env}/backuper.nix");
  package = builtins.fetchGit {
    url =
      "https://git.webwave.work/BrowserEmulation/playwrite-nixos-instance.git";
    ref = "main";
    rev = "4e0bab5f3a893690e3ee5d340325f96f18cf81a6";
  };
in {
  imports = [ "${package}/nix/service.nix" ];

  services.browserEmulationService = { enable = false; };
}
