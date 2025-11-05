{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.5.6";
    sha256 = "sha256-xVB4y80BFa9MRBsMYMSQmaRSNJVoeCiYW2UTJ+UpBYQ=";
  }
) {}
