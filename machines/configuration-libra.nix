{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "libra";
  imports = [
    ../machines/hardware-configuration-libra.nix
    ../config/config.nix
  ];
}
