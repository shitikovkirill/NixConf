{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ postgresql100 pgadmin ];
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql100;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;

      CREATE ROLE gitlab WITH LOGIN PASSWORD 'eXaMpl3' CREATEDB;
      CREATE DATABASE gitlab;
      GRANT ALL PRIVILEGES ON DATABASE gitlab TO gitlab;
    '';
  };
}
