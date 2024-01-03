{ pkgs ? import <nixpkgs> { } }:

pkgs.python3Packages.buildPythonApplication rec {
    pname = "sway-empty";
    version = "0.1.0";
    src = ./.;
    postInstall = "mv -v $out/bin/sway-empty.py $out/bin/sway-empty";
}
