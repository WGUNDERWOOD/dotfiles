{pkgs ? import <nixpkgs> {}}:
pkgs.fetchFromGitHub {
  owner = "wgunderwood";
  repo = "tex-fmt";
  rev = "164ee2f6c9894afc7c9522eb9d6dffbafa86cc20";
  sha256 = "sha256-zir2AFeTjr1miDaWOqcGyN8+bBOvs4G5jy7I/QN+9zw=";
}
