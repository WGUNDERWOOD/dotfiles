{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.5.4";
    sha256 = "sha256-CAuhIJbe483Qu+wnNfXTkQ3ERAbkt07QzZ7z7pcbl10=";
  }
) {}
