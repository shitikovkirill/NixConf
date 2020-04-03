{ config, pkgs, ... }:

{
  services.postgresql = {
      enable = true;
      ensureDatabases = [ "thinkglobal" ];
      ensureUsers = [{
        name = "kirill";
        ensurePermissions = {
          "DATABASE thinkglobal" = "ALL PRIVILEGES";
        };
      }];
    };

    services.redis = {
    enable = true;
  };
}
