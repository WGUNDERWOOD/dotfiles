{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.3.0";
    sha256 = "sha256-j5AwecYlywdPxeYcJpdpgVUlVNW8uuL9JD6Vf1IkeQI=";
  }
) {}
