{pkgs ? import <nixpkgs> {}}:
pkgs.python3Packages.buildPythonApplication rec {
  pname = "bib-down";
  version = "0.1.0";
  src = ./.;
  postInstall = "mv -v $out/bin/bib-down.py $out/bin/bib-down";
  propagatedBuildInputs = with pkgs.python3Packages; [
    habanero
    pyperclip
    unidecode
    colorama
  ];
}
