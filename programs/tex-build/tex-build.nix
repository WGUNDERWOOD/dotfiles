{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "tex-build";
  runtimeInputs = with pkgs; [texlive.combined.scheme-full];
  text = builtins.readFile ./tex-build.sh;
}
