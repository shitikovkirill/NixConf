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
        provision = { 
            enable = true;
            datasources = [ 
                { 
                    name = "NodeStatistic";
                    type = "prometheus";
                    url = "http://localhost:9090";
                    isDefault = true;
                    user = "admin";
                } 
            ];
        };
    };
    
    services.prometheus = {
        enable = true;
        scrapeConfigs = [
            {
                job_name = "prometeus";
                static_configs =  [ 
                    { 
                        targets = ["localhost:9090"];
                        labels = { alias = "prometeus"; };
                    }
                ];
            }
            {
                job_name = "node";
                static_configs =  [ 
                    { 
                        targets = ["localhost:9100"];
                        labels = { alias = "node"; };
                    }
                ];
            }
            {
                job_name = "postfix";
                static_configs =  [ 
                    { 
                        targets = ["localhost:9154"];
                        labels = { alias = "node"; };
                    }
                ];
            }
        ];
    };
    
    services.prometheus.exporters = {
        node = {
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
    };
}
 
