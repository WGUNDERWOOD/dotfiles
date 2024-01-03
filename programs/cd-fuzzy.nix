{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "cd-fuzzy";
    runtimeInputs = with pkgs; [ findutils fzf coreutils ];
    text = ''
        file=$(find "$HOME" -type f -print | fzf --tac)
        dir=$(dirname "$file")
        echo "$dir"
        echo "$file"
        [[ -n "$file" ]] && cd "$dir"
        exec bash
        '';
}
