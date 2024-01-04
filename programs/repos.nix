{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "repos";
    runtimeInputs = with pkgs; [ git bash coreutils ];
    text = ''
        fetch=""
        while getopts 'f' flag; do
            case "''${flag}" in
                f) fetch="true" ;;
                *) exit 1 ;;
            esac
        done

        check_repo() {
            cd "$1"
            if [ -d .git ]; then
                stat=$(git status -s)
                merge=$(git for-each-ref --format="%(upstream:track)" refs/heads |
                    grep "ahead\|behind")
                [[ -n "$stat$merge" ]] &&
                    echo -e "\e[0;31m\033[1m$(pwd)\e[0;30m\033[0m"
            fi
        }

        check_repo_fetch() {
            cd "$1"
            if [ -d .git ]; then
                git remote update > /dev/null 2> /dev/null
                stat=$(git status -s)
                merge=$(git for-each-ref --format="%(upstream:track)" refs/heads |
                    grep "ahead\|behind")
                [[ -n "$stat$merge" ]] &&
                    echo -e "\e[0;31m\033[1m$(pwd)\e[0;30m\033[0m"
            fi
        }

        export -f check_repo
        export -f check_repo_fetch

        if [ -n "$fetch" ]; then
            find "$HOME/github/" "$HOME/overleaf/" \
                -maxdepth 1 -mindepth 1 -type d -exec bash -c \
                'check_repo_fetch "$1"' \
                shell {} \
                \;
        else
            find "$HOME/github/" "$HOME/overleaf/" \
                -maxdepth 1 -mindepth 1 -type d -exec bash -c \
                'check_repo "$1"' \
                shell {} \
                \;
        fi
        '';
}
