{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.5.2";
    sha256 = "sha256-3kRtBfIT6QcdZ1+h2WwvxsAv/UJLtwSodF5zvCUDbHQ=";
  }
) {}
