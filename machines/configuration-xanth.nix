{...}: {
  networking.hostName = "xanth";
  system.stateVersion = "23.05";
  imports = [
    ../machines/hardware-configuration-xanth.nix
    ../config/config.nix
  ];
}
