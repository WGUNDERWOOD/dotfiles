{pkgs ? import <nixpkgs> {}}:
pkgs.python3Packages.buildPythonApplication rec {
  pname = "tex-fmt";
  version = "0.1.0";
  src = ./.;
  postInstall = "mv -v $out/bin/tex-fmt.py $out/bin/tex-fmt";
  #propagatedBuildInputs = with pkgs.python3Packages; [
    #habanero
    #pyperclip
    #unidecode
    #colorama
  #];
}
