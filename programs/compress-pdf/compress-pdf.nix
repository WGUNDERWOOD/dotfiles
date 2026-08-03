{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "compress-pdf";
  runtimeInputs = with pkgs; [coreutils ghostscript bashInteractive xxhash];
  text = builtins.readFile ./compress-pdf.sh;
}
