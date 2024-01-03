{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "tex-clean";
    runtimeInputs = with pkgs; [ coreutils ];
    text = ''
        rm -rfv \
            ./auto/ \
            ./*.aux \
            ./*-blx.bib \
            ./*.bbl \
            ./*.bcf \
            ./*.blg \
            ./*.dvi \
            ./*.fdb_latexmk \
            ./*.fls \
            ./*.glg \
            ./*.glo \
            ./*.gls \
            ./*.ist \
            ./*.lof \
            ./*.log \
            ./*.lot \
            ./*.nav \
            ./*.out \
            ./*.pytxcode \
            ./*.run.xml \
            ./*.sha256 \
            ./*.snm \
            ./*.synctex.gz \
            ./*.toc \
            ./*.xdv \
        '';
}

