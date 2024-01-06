{ config, pkgs, ... }:

{
  networking.hostName = "libra";
  imports = [
      ../machines/hardware-configuration-libra.nix
      ../config/config.nix
  ];
  system.stateVersion = "23.05"; # original release: do not edit
}
