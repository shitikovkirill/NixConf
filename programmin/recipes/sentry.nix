{ config, lib, pkgs, ... }:

let
  domain = "sentry.loc";
  proxy_pass = "127.0.0.1:9000";
  redis_host = "172.17.0.1";
  postgres_host = "172.17.0.1";
  db_user = "sentry";
  db_name = "sentry";
  db_password = "sentry";
  secret_key = "sentry";
in {
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 80 443 9001 ];
  };

  services.nginx = {
    enable = true;
    virtualHosts."${domain}" = {
      enableACME = false;
      forceSSL = false;
      locations = {
        "/".extraConfig = ''
          proxy_pass        http://${proxy_pass};
          add_header Strict-Transport-Security "max-age=31536000";
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [ docker ];

  virtualisation.docker.enable = true;

  systemd.services.sentry_web = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      TimeoutStartSec = 0;
      Restart = "always";
      ExecStartPre = [ "-${pkgs.docker}/bin/docker pull sentry" ];
      ExecStart = ''
        ${pkgs.docker}/bin/docker run \
                --rm \
                -p ${proxy_pass}:9000 \
                -e SENTRY_URL_PREFIX=https://${domain} \
                -e SENTRY_REDIS_HOST=${redis_host} \
                -e SENTRY_POSTGRES_HOST=${postgres_host} \
                -e SENTRY_DB_USER=${db_user} \
                -e SENTRY_DB_NAME=${db_name} \
                -e SENTRY_DB_PASSWORD=${db_password} \
                -e SENTRY_SECRET_KEY=${secret_key} \
                sentry run web'';
    };
  };

  systemd.services.sentry_worker = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      TimeoutStartSec = 0;
      Restart = "always";
      ExecStartPre = [ "-${pkgs.docker}/bin/docker pull sentry" ];
      ExecStart = ''
        ${pkgs.docker}/bin/docker run \
                --rm \
                -e SENTRY_URL_PREFIX=https://${domain} \
                -e SENTRY_REDIS_HOST=${redis_host} \
                -e SENTRY_POSTGRES_HOST=${postgres_host} \
                -e SENTRY_DB_USER=${db_user} \
                -e SENTRY_DB_NAME=${db_name} \
                -e SENTRY_DB_PASSWORD=${db_password} \
                -e SENTRY_SECRET_KEY=${secret_key} \
                sentry run worker'';
    };
  };

  systemd.services.sentry_cron = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    requires = [ "docker.service" ];
    serviceConfig = {
      TimeoutStartSec = 0;
      Restart = "always";
      ExecStartPre = [ "-${pkgs.docker}/bin/docker pull sentry" ];
      ExecStart = ''
        ${pkgs.docker}/bin/docker run \
                --rm \
                -e SENTRY_URL_PREFIX=https://${domain} \
                -e SENTRY_REDIS_HOST=${redis_host} \
                -e SENTRY_POSTGRES_HOST=${postgres_host} \
                -e SENTRY_DB_USER=${db_user} \
                -e SENTRY_DB_NAME=${db_name} \
                -e SENTRY_DB_PASSWORD=${db_password} \
                -e SENTRY_SECRET_KEY=${secret_key} \
                sentry run cron'';
    };
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
      host all all 0.0.0.0/0 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE ${db_user} WITH LOGIN PASSWORD '${db_password}' CREATEDB;
      CREATE DATABASE ${db_name};
      GRANT ALL PRIVILEGES ON DATABASE ${db_name} TO ${db_user};
      ALTER USER ${db_user} WITH SUPERUSER;
    '';
  };

  services.redis = {
    enable = true;
    bind = "0.0.0.0";
  };

}
