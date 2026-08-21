{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    with flake-utils.lib;
      eachSystem allSystems (system: let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python3.withPackages (ps:
          with ps; [
            pillow
          ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            python
            pkgs.resvg
          ];
        };
      });
}
