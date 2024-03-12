{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "tex-clean";
  runtimeInputs = with pkgs; [coreutils];
  text = builtins.readFile ./tex-clean.sh;
}
