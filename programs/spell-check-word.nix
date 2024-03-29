{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "spell-check-word";
  runtimeInputs = with pkgs; [coreutils aspell];
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
            tail -n +2 | cut -c 3- | cut -d ' ' -f 4-)"
    elif [ "$lang" == "british" ]; then
        out="$(echo "$word" | aspell -a --lang=en_GB | \
            tail -n +2 | cut -c 3- | cut -d ' ' -f 4-)"
    else
        exit 1
    fi

    if [ -n "$out" ]; then
        echo "N \"$word\". Try: $out"
    else
        echo "Y \"$word\""
    fi
  '';
}
