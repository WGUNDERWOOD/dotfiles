{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.4.7";
    sha256 = "sha256-jVrd3yZ07+ppsdt+8sNKX1rdmU+UiRCyx80EMXdoK54=";
  }
) {}
