{ config, pkgs, ... }:
let 
    secretPath = "/var/gitlab/key/gitlab";
    mainHost = "webwave.loc";
    gitUser = "git";
in {
    services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        virtualHosts."git.${mainHost}" = {
            enableACME = false;
            forceSSL = false;
            # listen.port = 8080;
            locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
        };
    };
    
    networking.firewall.allowedTCPPorts = [80];

    services.gitlab = {
        enable = true;
        databasePasswordFile = "${secretPath}/db_password";
        initialRootPasswordFile = "${secretPath}/root_password";
        https = false;
        host = "git.${mainHost}";
        port = 80;
        user = gitUser;
        group = gitUser;
        databaseUsername = gitUser;

        secrets = {
            dbFile = "${secretPath}/db";
            secretFile = "${secretPath}/secret";
            otpFile = "${secretPath}/otp";
            jwsFile = "${secretPath}/jws";
        };
        
        smtp = {
            enable = true;
            address = "localhost";
            port = 1025;
        };
        
        extraConfig = {
            gitlab = {
                email_from = "gitlab-no-reply@${mainHost}";
                email_display_name = "Example GitLab";
                email_reply_to = "gitlab-no-reply@${mainHost}";
                default_projects_features = { builds = false; };
            };
        };
    };
}
