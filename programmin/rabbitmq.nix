{ config, pkgs, ... }:

{
  services.rabbitmq = {
    enable = true;
    listenAddress = "0.0.0.0";
    plugins = [ "rabbitmq_management" ];
    config = "[{rabbit, [{loopback_users, []}]}].";
  };
}
