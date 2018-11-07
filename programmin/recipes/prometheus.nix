{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      prometheus
   ];

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
    firewallFilter = "-i br0 -p tcp -m tcp --dport 9100";
  };
}

