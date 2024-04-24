{pkgs ? import <nixpkgs> {}}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "sway-empty";
  version = "0.1.0";
  propagatedBuildInputs = with pkgs; [
    sway
  ];
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
}
