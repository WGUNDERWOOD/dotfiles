{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "spell-check-fix";
  runtimeInputs = with pkgs; [coreutils aspell gnused];
  text = ''
    lang="british"
    while getopts "ba" flag; do
        case "''${flag}" in
            b) lang="british" ;;
            a) lang="american" ;;
            *) exit 1 ;;
        esac
    done

    shift $((OPTIND - 1))
    word="$*"

    if [ "$lang" == "american" ]; then
        out="$(echo "$word" | aspell -a --lang=en_US | \
            tail -n +2 | cut -c 3- | cut -d ' ' -f 4 | sed 's/,//' )"
    elif [ "$lang" == "british" ]; then
        out="$(echo "$word" | aspell -a --lang=en_GB | \
            tail -n +2 | cut -c 3- | cut -d ' ' -f 4 | sed 's/,//' )"
    else
        exit 1
    fi

    if [ -n "$out" ]; then
        echo -n "$out"
    else
        echo -n "$word"
    fi
  '';
}
