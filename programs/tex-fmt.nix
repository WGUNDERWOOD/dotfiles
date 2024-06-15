{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.2.2";
    sha256 = "sha256-yHTxwbPHBnq3NqT9RcqxXxw6Sjc7guomwDA/iIzOlbU=";
  }
) {}
