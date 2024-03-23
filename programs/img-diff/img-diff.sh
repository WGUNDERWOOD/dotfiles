#!usr/bin/env bash

TEMP="$HOME/tmp/temp.png"
DIFF="$HOME/tmp/diff.png"

compare "$1" "$2" "$TEMP"
convert +append "$1" "$2" "$TEMP" "$DIFF"
feh --scale-down "$DIFF"
