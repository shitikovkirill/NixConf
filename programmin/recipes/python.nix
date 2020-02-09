{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pythonFull
    python36Packages.virtualenvwrapper
    zest-releaser-python2
    zest-releaser-python3
  ];
}
