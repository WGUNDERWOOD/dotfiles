{pkgs ? import <nixpkgs> {}}:
pkgs.rustPlatform.buildRustPackage rec {
  pname = "spell-check";
  version = "0.1.0";
  propagatedBuildInputs = with pkgs; [
      coreutils
      aspell
      aspellDicts.en
  ];
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
}
