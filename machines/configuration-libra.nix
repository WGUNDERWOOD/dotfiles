{ config, pkgs, ... }:

{
  networking.hostName = "libra";
  imports = [ ./common.nix ];
}
