{ config, pkgs, ... }:
{
    networking.wireless = {
        enable = true;
        userControlled.enable = true;
        interfaces = [ "wlp2s0" ];
        networks = {
            TP-LINK_370DEA = {
                psk="24072011";
            };
        };
    };
}
