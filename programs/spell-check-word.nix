{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "spell-check-word";
    runtimeInputs = with pkgs; [ coreutils aspell ];
    text = ''
        word="$1"
        out="$(echo "$word" | aspell -a | tail -n +2 | cut -c 3- | cut -d ' ' -f 4-)"
        if [ -n "$out" ]; then
            echo -n "N \"$word\". Try: $out"
        else
            echo -n "Y \"$word\""
        fi
        '';
}
