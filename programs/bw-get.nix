{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "bw-get";
    runtimeInputs = with pkgs; [ bitwarden-cli coreutils ];
    text = ''
        # TODO get color output from bitwarden
        # declare items to get from bitwarden
        PWLIST=(
                "neomutt_gmail_email" \
                "neomutt_gmail_password" \
                "neomutt_princeton_email" \
                "neomutt_princeton_password" \
               )

        # unlock and update bitwarden local vault
        SESSION=$(bw unlock --raw)
        bw sync
        mkdir -p "$HOME/tmp/bw/"

        # get items
        for ITEM in "''${PWLIST[@]}"; do
            echo "$ITEM"
            PWFILE="$HOME/tmp/bw/$ITEM"
            PW=$(bw get password "$ITEM" --session "$SESSION")
            echo "$PW" > "$PWFILE"
        done
        '';
}
