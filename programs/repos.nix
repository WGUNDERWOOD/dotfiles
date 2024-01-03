{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "repos";
    runtimeInputs = with pkgs; [ git bash coreutils ];
    text = ''
        find "$HOME/github/" "$HOME/overleaf/" \
            -maxdepth 1 -mindepth 1 -type d -exec bash -c \
            'cd "$1" &&
            [ -d .git/ ] &&
            [[ -n $(git status -s) ]] &&
            echo -e "\e[0;31m\033[1m$(pwd)\e[0;30m\033[0m"' \
            shell {} \
            \;
        '';
}
