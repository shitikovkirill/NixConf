{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.myMetrics;
  grafanaDashboard = dashboardId:
    builtins.fetchurl ("https://grafana.com/api/dashboards/${
        toString dashboardId
      }/revisions/1/download");

  nginxDashbord = builtins.fetchGit {
    url = "https://github.com/nginxinc/nginx-prometheus-exporter.git";
    ref = "main";
  };

  dashboardsDir = pkgs.runCommand "grafana-dashboards" { } ''
    mkdir -p $out
    ln -sf ${grafanaDashboard 12486} $out/node.json
    ln -sf ${nginxDashbord}/grafana/dashboard.json $out/nginx.json
  '';
in {
  options = {
    services.myMetrics = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable service.
        '';
      };

      adminEmail = mkOption {
        type = types.str;
        example = "admin@example.com";
        description = ''
          Admin emale
        '';
      };

      pagerdutyKey = mkOption {
        type = types.str;
        description = "PagerDuty secret key";
      };

      slackApiUrl = mkOption {
        type = types.str;
        description = "PagerDuty secret key";
      };

      https = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable https.
        '';
      };

      domain = mkOption {
        type = types.str;
        description = "domain";
      };

      nodeTargets = mkOption {
        default = [ ];
        description = ''
          List of targets.
        '';
      };

      nginxTargets = mkOption {
        default = [ ];
        description = ''
          List of targets.
        '';
      };

      postfixTargets = mkOption {
        default = [ ];
        description = ''
          List of targets.
        '';
      };

      rabbitmqTargets = mkOption {
        default = [ ];
        description = ''
          List of targets.
        '';
      };

      jsonTargets = mkOption {
        default = [ ];
        description = ''
          List of targets.
        '';
      };

      postgresTargets = mkOption {
        default = [ ];
        description = ''
          List of targets.
        '';
      };

      auth = mkOption {
        type = types.attrsOf types.str;
        default = { };
        example = literalExample ''
          {
            user = "password";
          };
        '';
        description = ''
          Basic Auth protection for a vhost.
          WARNING: This is implemented to store the password in plain text in the
          nix store.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    networking = { firewall = { allowedTCPPorts = [ 80 443 3100 ]; }; };

    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts."grafana.${cfg.domain}" = {
        enableACME = cfg.https;
        forceSSL = cfg.https;
        locations = { "/" = { proxyPass = "http://localhost:3000"; }; };
      };
      virtualHosts."prometeus.${cfg.domain}" = {
        enableACME = cfg.https;
        forceSSL = cfg.https;
        basicAuth = cfg.auth;
        locations = { "/" = { proxyPass = "http://localhost:9090"; }; };
      };
    };

    services.grafana = {
      enable = true;
      settings = {
        server = {
          # Listening Address
          http_addr = "127.0.0.1";
          # and Port
          http_port = 3000;
          # Grafana needs to know on which domain and URL it's running
          domain = "grafana.${cfg.domain}";
        };
      };
      provision = {
        enable = true;
        datasources.settings.datasources = [
          {
            name = "NodeStatistic";
            type = "prometheus";
            url = "http://localhost:9090";
            isDefault = true;
            user = "admin";
          }
          {
            name = "Logs";
            type = "loki";
            url = "http://localhost:3100";
            user = "admin";
          }
        ];
        dashboards.settings.providers = [{
          name = "Node dashboard";
          options.path = dashboardsDir;
          disableDeletion = true;
        }];
      };
    };

    services.prometheus = {
      enable = true;
      ruleFiles = [ ./rules.yaml ];
      scrapeConfigs = [
        {
          job_name = "prometeus";
          static_configs = [{
            targets = [ "localhost:9090" ];
            labels = { alias = "prometeus"; };
          }];
        }
        {
          job_name = "node";
          static_configs = [{
            targets = [ "localhost:9100" ] ++ cfg.nodeTargets;
            labels = { role = "node"; };
          }];
        }
        {
          job_name = "nginx";
          static_configs = [{
            targets = cfg.nginxTargets;
            labels = { role = "nginx"; };
          }];
        }
        {
          job_name = "postfix";
          static_configs = [{
            targets = cfg.postfixTargets;
            labels = { role = "postfix"; };
          }];
        }
        {
          job_name = "rabbitmq";
          static_configs = [{
            targets = cfg.rabbitmqTargets;
            labels = { role = "rabbitmq"; };
          }];
        }
        {
          job_name = "json";
          static_configs = [{
            targets = cfg.jsonTargets;
            labels = { role = "json"; };
          }];
          scrape_interval = "15m";
        }
        {
          job_name = "postgres";
          static_configs = [{
            targets = cfg.postgresTargets;
            labels = { role = "postgres"; };
          }];
        }
      ];
      alertmanager = {
        enable = true;
        # https://grafana.com/blog/2020/02/25/step-by-step-guide-to-setting-up-prometheus-alertmanager-with-slack-pagerduty-and-gmail/
        configuration = {
          global = {
            resolve_timeout = "1m";
            slack_api_url = cfg.slackApiUrl;
          };
          route = { receiver = "slack-notifications"; };
          receivers = [{
            name = "slack-notifications";
            slack_configs = [{
              channel = "#alerts";
              send_resolved = true;
            }];
          }];
        };
      };
      alertmanagers =
        [{ static_configs = [{ targets = [ "localhost:9093" ]; }]; }];
    };

    services.loki = {
      enable = true;
      configFile = ./loki.yaml;
    };

    services.postfix = { enable = true; };
  };
}
