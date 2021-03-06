{ config, pkgs, ... }: {
  users.users = {
    kirill = {
      isNormalUser = true;
      home = "/home/kirill";
      description = "Kirill Shitikov";
      # shell = pkgs.zsh;
      extraGroups = [ "wheel" "networkmanager" "audio" "dialout" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNn9/HiMf700rmBQwC7qtta1AHL0kwhFwM9zR5xFyz7x/Ez6cgvjKz9PdEh1NFsTI5Ys67+eJj5TchdqXLWz9pRzs+alCdGjmaOPKPu1nQAAIfvy+LtGwChUmzlR8TKQuQjVOns/8VhNODb/jASSf7w8k7hpqu18QJSYB9XtCxxbcc2mFwI3P2/H/nrZ2SFD09+ukr9u+wEICjekDu8G8wpjdB8GtzKL6XONPSg5NgAO7+kq3rqYK2oWHUA5GSZOwk97eHgIixrO9W3m9Bl6ZQ9M9biRhJDiixnM8XCLF8zfql42Yrja+dsDcNckbY8iusLp5+opt6hQpml4EoXU/T kirill@asus"
      ];
    };
    root = { extraGroups = [ "wheel" "networkmanager" "audio" ]; };
  };
}
