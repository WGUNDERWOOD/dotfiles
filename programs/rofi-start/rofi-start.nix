{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "rofi-start";
  runtimeInputs = with pkgs; [coreutils yq rofi];
  text = builtins.readFile ./rofi-start.sh;
}
