{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "xanth";
  imports = [
    ../machines/hardware-configuration-xanth.nix
    ../config/config.nix
  ];
}
