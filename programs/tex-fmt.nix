{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.3.1";
    sha256 = "sha256-v5tFPRjNgoNxh/lqvGQ0ozxgsRKSf6fI/3pWG+KFbl8=";
  }
) {}
