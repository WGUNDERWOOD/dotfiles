{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "compress-pdf";
  runtimeInputs = with pkgs; [coreutils ghostscript bashInteractive];
  text = builtins.readFile ./compress-pdf.sh;
}
