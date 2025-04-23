{ config, pkgs, lib, ... }:
let
  env = config.services.appConfig.env;
  #secrets = import (../../../secrets + builtins.toPath "/${env}/backuper.nix");
  package = builtins.fetchGit {
    url = "https://git.webwave.work/TelegramBot/vtb-python.git";
    ref = "main";
    rev = "cba143b6361b3aaed9b04885911a998ca16008f2";
  };
in {
  imports = [ "${package}/nix/service.nix" ];

  services.videoTelegramBotService = {
    enable = false;
    https = false;
    domain = "vtb.webwave.work";
    environment = {
      ENV = "dev";
      API_TOKEN = "...";
      WEBHOOK_HOST = "vtb.webwave.work";
      WEBHOOK_SSL_CERT = "/var/lib/videotb/fullchain.pem";
    };
  };
}
