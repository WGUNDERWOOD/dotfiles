{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "player-art";
  runtimeInputs = with pkgs; [coreutils curl procps feh playerctl];
  text = ''
    DIR="$HOME/tmp/player-art"
    URL_FILE="$DIR/player-art-url.tmp"
    IMG_FILE="$DIR/player-art-img.tmp"

    # get art url and image or exit if nothing is playing
    mkdir -p "$DIR"
    playerctl -p spofity metadata mpris:artUrl > "$URL_FILE" || exit 1
    curl "$(cat "$URL_FILE")" --output "$IMG_FILE"

    # view the album art
    feh -F "$IMG_FILE" &
    PID="$!"

    # while image viewer is still open
    while ps -p $PID > /dev/null; do

        # get the last url from disk
        URL_OLD="$(cat "$URL_FILE")"

        # update the current url or exit if no player
        playerctl -p spofity metadata mpris:artUrl > "$URL_FILE" || kill $PID
        URL_NEW="$(cat "$URL_FILE")"

        # get a new image if the url has changed
        if [ "$URL_OLD" != "$URL_NEW" ]; then
            curl "$URL_NEW" --output "$IMG_FILE"
        fi

        sleep 1
    done
  '';
}
