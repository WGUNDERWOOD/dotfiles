{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "495cf17c6aa28ec9e257389fe62d1f1731169a86";
    sha256 = "sha256-I6qNCvDEkPefkXEoSEOluNJcAqgX1RjB+rMwDfykpHQ=";
  }
) {}
