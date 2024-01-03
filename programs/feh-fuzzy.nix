{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "feh-fuzzy";
    runtimeInputs = with pkgs; [ findutils fzf coreutils screen feh ];
    text = ''
        file=$(find "$HOME" -type f \
                \( -name '*.png' -or -name '*.svg' \
                -or -name '*.jpg' -or -name '*.jpeg' \) \
                -print | fzf --tac)
        echo "$file"
        [[ -n "$file" ]] && screen -d -m feh "$file" && sleep 0.1
        '';
}
