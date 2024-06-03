{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.2.0";
    sha256 = "sha256-METpQlN1lzum5jt4zyT9po71gfA5dlzFPMJ1KWAzp0U=";
  }
) {}
