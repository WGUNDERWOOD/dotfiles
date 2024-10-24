{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.4.6";
    sha256 = "sha256-Ii/z9ZmsWCHxxqUbkcu7HRBuN2LiLCxzUvqRexwQ/Co=";
  }
) {}
