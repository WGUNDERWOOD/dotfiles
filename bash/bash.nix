{pkgs, ...}: {
    home.file.".bash_config.sh".source = ./.bash_config.sh;
    home.file.".bash_aliases.sh".source = ./.bash_aliases.sh;
    home.file."scripts/optpdf".source = ./optpdf;
    home.file."scripts/spell_check".source = ./spell_check;
    home.file."scripts/cd_fuzzy".source = ./cd_fuzzy;
    home.file."scripts/zathura_fuzzy".source = ./zathura_fuzzy;
    home.file."scripts/feh_fuzzy".source = ./feh_fuzzy;
    home.file."scripts/fd_git".source = ./fd_git;
    home.file."scripts/rg_git".source = ./rg_git;
    home.file."scripts/todo_finder".source = ./todo_finder;
    home.file."scripts/longest_lines".source = ./longest_lines;

    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            "g" = "git";
        };
        initExtra = ''
            source $HOME/.bash_config.sh
            source $HOME/.bash_aliases.sh
            '';
    };
}
