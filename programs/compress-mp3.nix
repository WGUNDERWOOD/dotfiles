{ pkgs ? import <nixpkgs> { } }:

pkgs.writeShellApplication {
    name = "compress-mp3";
    runtimeInputs = with pkgs; [ coreutils ffmpeg ];
    text = ''
        # arg 1: file to compress
        # arg 2: bitrate e.g. 160k

        if [[ $1 != *.mp3 ]]; then
            echo "File is not an mp3"
            exit 1
        fi

        if [ -z "$2" ]; then
            echo "Please supply a bitrate"
            exit 1
        fi

        FILE="$(basename -s .mp3 "$1")"
        TEMP="/home/will/tmp/''${FILE}_cmp.mp3"
        ffmpeg -y -i "$1" -acodec libmp3lame -ab "$2" "$TEMP"
        mv "$TEMP" .
        '';
}

