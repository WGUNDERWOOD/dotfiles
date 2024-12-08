{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.5.0";
    sha256 = "sha256-WTR/QlqOIFjPXrjy3FjudZ1GxhN8folFx3cPvdjZ+TQ=";
  }
) {}
