{pkgs ? import <nixpkgs> {}}:
pkgs.callPackage (
  pkgs.fetchFromGitHub {
    owner = "wgunderwood";
    repo = "tex-fmt";
    rev = "v0.4.1";
    sha256 = "sha256-1gHz8xHkSKu4/BkOuxRIXVfHwJPWJTh5AogETlAsuys=";
  }
) {}
