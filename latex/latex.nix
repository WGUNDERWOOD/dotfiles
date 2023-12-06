{pkgs, ...}: {
    home.file.".latexmkrc".source = ./.latexmkrc;
    home.file."scripts/texclean".source = ./texclean;
    home.file."scripts/tex_log_parse".source = ./tex_log_parse;
    home.file."scripts/bibtex-download".source = ./bibtex-download;
    home.file."scripts/latexindent_fast".source = ./bibtex-download;
    home.file."scripts/tex_labels".source = ./bibtex-download;
    home.file.".indentsettings.yaml".source = ./.indentsettings.yaml;
    home.file.".indentconfig.yaml".text = ''
        paths:
        - /home/will/.indentsettings.yaml
    '';
}
