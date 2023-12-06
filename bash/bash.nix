{pkgs, ...}: {
    home.file.".bash_config.sh".source = ./.bash_config.sh;
    home.file.".bash_aliases.sh".source = ./.bash_aliases.sh;
    home.file."scripts/optpdf".source = ./optpdf;
    home.file."scripts/spell_check".source = ./spell_check;
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
