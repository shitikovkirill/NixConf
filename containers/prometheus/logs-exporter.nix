{ config, lib, pkgs, ... }:
with lib;
let cfg = config.services.logsExporter;
in {
  options = {
    services.logsExporter = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable service.
        '';
      };

      configFile = mkOption {
        type = types.path;
        description = ''
          Promtail config file in yaml format. Config example ./promtail.yaml
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    systemd.services.promtail = {
      description = "Promtail service for Loki";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = ''
          ${pkgs.grafana-loki}/bin/promtail --config.file ${cfg.configFile}
        '';
      };
    };
  };
}
