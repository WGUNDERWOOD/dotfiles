{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.4.4";
    sha256 = "sha256-o8TlD0qxz/0sS45tnBNXYNDzp+VAhH3Ym1odSleD/uw=";
  }
) {}
