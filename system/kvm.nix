{
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
  users.extraUsers.kirill.extraGroups = [ "libvirtd" ];
  networking.firewall.checkReversePath = false;
}
