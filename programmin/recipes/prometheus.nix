{ config, pkgs, ... }:
let 
    mainHost = "webwave.loc";
in {
    services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        virtualHosts."grafana.${mainHost}" = {
            enableACME = false;
            forceSSL = false;
            locations = {
                "/" = {
                    proxyPass = "http://localhost:3000";
                };
            };
        };
        virtualHosts."prometeus.${mainHost}" = {
            enableACME = false;
            forceSSL = false;
            locations = {
                "/" = {
                    proxyPass = "http://localhost:9090";
                };
            };
        };
    };
    
    services.grafana = {
        enable = true;
        #addr = "0.0.0.0";
        provision.datasources = [
            { 
                name = "LocalServer";
                type = "prometheus"; 
                url = "http://localhost:9090";
            }
        ];
    };
    
    services.prometheus = {
        enable = true;
        scrapeConfigs = [
            {
                job_name = "prometeus";
                static_configs =  [ 
                    { targets = ["localhost:9090"]; }
                ];
            }
            {
                job_name = "node";
                static_configs =  [ 
                    { targets = ["localhost:9100"]; }
                ];
            }
        ];
    };
    
    services.prometheus.exporters.node = {
        enable = true;
        enabledCollectors = [
            "logind"
            "systemd"
        ];
        disabledCollectors = [
            "textfile"
        ];
        openFirewall = true;
        #firewallFilter = "-i br0 -p tcp -m tcp --dport 9100";
    };
}
 
