{pkgs ? import <nixpkgs> {}}:
pkgs.python3Packages.buildPythonApplication rec {
  pname = "rename-pdf";
  version = "0.1.0";
  src = ./.;
  postInstall = "mv -v $out/bin/rename-pdf.py $out/bin/rename-pdf";
  prettyErrors = pkgs.python3Packages.buildPythonPackage rec {
    pname = "pretty_errors";
    version = "1.2.25";
    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-oWulx1LIfCY7+S+LS1hiTjseKScak5H1ZPErhuk8Z1U=";
    };
    doCheck = false;
  };
  propagatedBuildInputs = with pkgs.python3Packages; [
    prettyErrors
    unidecode
    colorama
    pathlib2
    feedparser
    urllib3
  ];
}
