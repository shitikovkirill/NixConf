 
{ config, pkgs, ... }:
{ 
    services.httpd.enable = true;
    services.httpd.adminAddr = "alice@example.org";
    services.httpd.virtualHosts = {
        "webtest.containers" = {
            documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
        };
    };
    networking.firewall.allowedTCPPorts = [ 80 ];
}
