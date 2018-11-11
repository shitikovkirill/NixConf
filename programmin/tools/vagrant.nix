{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  [
    virtualbox
    vagrant
    linuxPackages.virtualboxGuestAdditions
  ];
   virtualisation.virtualbox = {
     guest.enable = true;
     host.enable = true;
   };

  # Minimal configuration for NFS support with Vagrant.
  services.nfs.server.enable = true;
  # !!! This is "unsafe", ports needed should be found and fixed here.
  networking.firewall.enable = false;
}
