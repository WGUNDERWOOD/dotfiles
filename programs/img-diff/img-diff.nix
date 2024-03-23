{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "img-diff";
  runtimeInputs = with pkgs; [coreutils imagemagick feh];
  text = builtins.readFile ./img-diff.sh;
}
