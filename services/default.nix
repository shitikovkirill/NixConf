{ config, lib, pkgs, ... }:

{
  services.gitea = {
    enable = true;
    database = { type = "sqlite3"; };
    settings.log.LEVEL = "Debug";
    extraConfig = ''
      [oauth2_client]
      ENABLE_AUTO_REGISTRATION = true
      USERNAME = email
      ACCOUNT_LINKING = auto

      [openid]
      ENABLE_OPENID_SIGNIN = true
      ENABLE_OPENID_SIGNUP = true
    '';
  };
}
