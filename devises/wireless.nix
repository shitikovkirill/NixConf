{ config, pkgs, ... }:
{
    networking.wireless = {
        enable = true;
        userControlled.enable = true;
        interfaces = [ "wlp2s0" ];
        networks = {
            TP-LINK_folnet = {
                psk="23072011";
            };
        };
    };
}
