{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ python3 winpdb ];

  programs.zsh = { ohMyZsh = { plugins = [ "python" "django" ]; }; };

  environment.shellAliases = {
    py-clean = ''find -name "*.pyc" -delete'';
  };
}
