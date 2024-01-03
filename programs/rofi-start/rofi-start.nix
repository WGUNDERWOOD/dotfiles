{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "rofi-start";
    runtimeInputs = with pkgs; [ coreutils jq rofi-wayland ];
    text = builtins.readFile ./rofi-start.sh;
}
