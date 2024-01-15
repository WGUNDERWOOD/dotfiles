{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "pdf-insert-blank-pages";
  runtimeInputs = with pkgs; [coreutils pdftk texlive.combined.scheme-full];
  text = ''
    # get directory names
    current_dir="$(pwd)"
    new_dir="$(mktemp -d)"

    # copy to new directory
    mkdir -p "$new_dir"
    cp "$1" "$new_dir/in.pdf"
    cd "$new_dir"

    # make blank page
    printf "
        \\\documentclass{article}
        \\\pagenumbering{gobble}
        \\\begin{document}
        \\\mbox{}
        \\\end{document}
        " > blank.tex
    latexmk -pdf -quiet -rc-report- blank

    # insert blank pages
    pdftk in.pdf burst
    for i in pg*.pdf; do
        printf "%s\nblank.pdf\n" "$i" >> list;
    done
    args=()
    mapfile -t args < "list"
    pdftk "''${args[@]}" cat output out.pdf

    # move back
    cd "$current_dir"
    filename="$(basename "$1" ".pdf")"
    cp "$new_dir/out.pdf" "$current_dir/''${filename}_blanks.pdf"
    rm -r "$new_dir"
  '';
}
