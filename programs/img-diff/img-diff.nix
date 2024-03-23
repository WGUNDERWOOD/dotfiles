{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "img-diff";
  runtimeInputs = with pkgs; [coreutils];
  text = builtins.readFile ./img-diff.sh;
}
