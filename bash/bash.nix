{pkgs, ...}: {
    home.file.".bash_config.sh".source = ./.bash_config.sh;
    home.file.".bash_aliases.sh".source = ./.bash_aliases.sh;
    home.file."scripts/spell_check_word".source = ./spell_check_word;
    home.file."scripts/zathura_fuzzy".source = ./zathura_fuzzy;
    home.file."scripts/feh_fuzzy".source = ./feh_fuzzy;
    home.file."scripts/fd_git".source = ./fd_git;
    home.file."scripts/rg_git".source = ./rg_git;
    home.file."scripts/compress-pdf".source = ./compress-pdf;

    programs.bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
            source $HOME/.bash_config.sh
            source $HOME/.bash_aliases.sh
            '';
    };
}
