{ config, pkgs, ... }: {
  imports = [ ./service.nix ./exporter.nix ./logs-exporter.nix ];

  services.myMetrics = {
    enable = true;
    https = false;
    domain = "monitor.local";
    adminEmail = "sh.kiruh@gmail.com";
    slackApiUrl =
      "https://hooks.slack.com/services/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";
    #nodeTargets = [
    #  "moodle.thinkglobal.online:9100"
    #  "thinkglobal.online:9100"
    #  "gitlab.thinkglobal.space:9100"
    #];
    #nginxTargets = [
    #  "gitlab.thinkglobal.space:9113"
    #  "ms.thinkglobal.online:9113"
    #  "ms-dev.thinkglobal.online:9113"
    #];
    #postfixTargets = [ "web:9154" ];
    #rabbitmqTargets = [ "web:15692" ];
    #jsonTargets = [ "web:9111" ];
    #postgresTargets =
    #[ "ms.thinkglobal.online:9187" "ms-dev.thinkglobal.online:9187" ];
  };

  services.logsExporter = {
    enable = true;
    configFile = ./promtail.yaml;
  };
}
