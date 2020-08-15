let hosts = import ./load-hosts.nix;
in {
  networking.hosts = ({
  "0.0.0.0" = [ "account.jetbrains.com" ];
  "192.168.1.150" = [ "dev.server" "prometheus.server" "grafana.server" "mail.server" "jupyter.server" "rabbitmq.server"];
  }) // hosts;
}
