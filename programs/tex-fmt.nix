{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.4.2";
    sha256 = "sha256-fm55jaw1dj5rZWz8oF1o5WtjYjxNwnrD6GGa3OgZSpA=";
  }
) {}
