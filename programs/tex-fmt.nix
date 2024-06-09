{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.2.1";
    sha256 = "sha256-XHUKQ747Eh8iNxYYB1wmZa0EwnuW7n5ZipuU8MCJPlc=";
  }
) {}
