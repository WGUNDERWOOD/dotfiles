{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "latexindent-fast";
  runtimeInputs = with pkgs; [coreutils texlive.combined.scheme-full];
  text = builtins.readFile ./latexindent-fast.sh;
}
