{...}: {
  networking.hostName = "libra";
  system.stateVersion = "23.05";
  imports = [
    ../machines/hardware-configuration-libra.nix
    ../config/config.nix
  ];
}
