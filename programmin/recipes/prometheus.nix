{ config, pkgs, ... }:

{
    networking.firewall.allowedTCPPorts = [9090];
    services.prometheus = {
        enable=true;
        exporters.node = {
            enable = true;
            enabledCollectors = [
                "logind"
                "systemd"
            ];
            disabledCollectors = [
                "textfile"
            ];
            openFirewall = true;
            firewallFilter = "-i br0 -p tcp -m tcp --dport 9100";
        };
    };
}
 
