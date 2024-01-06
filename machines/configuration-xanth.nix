{ config, pkgs, ... }:

{
  networking.hostName = "xanth";
  imports = [
      ../machines/hardware-configuration-xanth.nix
      ../config/config.nix
  ];
  system.stateVersion = "23.11"; # original release: do not edit
}
