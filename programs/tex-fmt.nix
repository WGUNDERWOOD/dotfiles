{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.4.5";
    sha256 = "sha256-QFtY+vJPVxbNXbDyZq3PaIHxa7rI/AAUdvnnMxLFVWY=";
  }
) {}
