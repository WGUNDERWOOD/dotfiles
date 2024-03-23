#!usr/bin/env bash
echo "$1"
compare "$2" "$1" png:- | \
    montage -font Source-Code-Pro -geometry +4+4 "$2" - "$1" png:- | \
    feh --scale-down - || true
