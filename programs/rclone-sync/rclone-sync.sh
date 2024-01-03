#!/usr/bin/env bash
# TODO make the output terser

EXCLUDEDIR="$HOME/.config/rclone/"

# get repository and direction from flags
repo=""
direc=""
while getopts "gdpls" flag; do
    case "${flag}" in
        g) repo="google_drive" ;;
        p) repo="google_drive_princeton" ;;
        d) repo="dropbox_princeton" ;;
        l) direc="pull" ;;
        s) direc="push" ;;
        *) exit 1 ;;
    esac
done

# repo names
case "$repo" in
    "google_drive") repo_name="Google Drive";;
    "google_drive_princeton") repo_name="Google Drive Princeton";;
    "dropbox_princeton") repo_name="Dropbox Princeton";;
    *) exit 1;;
esac

# repo variables
exclude="$EXCLUDEDIR/rclone_excludes_$repo.txt"
near="$HOME/rclone/$repo/"
nearshared="$HOME/rclone/$repo/Shared/"
far="$repo:"

# direction
case "$direc" in
    "pull")
        from="$far"; to="$near";
        fromshared="$far"; toshared="$nearshared";;
    "push")
        from="$near"; to="$far";
        fromshared="$nearshared"; toshared="$far";;
    *) exit 1;;
esac

echo -e "\e[0;35m\033[1mrclone $direc $repo_name\e[0;30m\033[0m"

# run rclone
case "$repo" in
    "google_drive"|"google_drive_princeton")
        echo -e "\e[0;33m\033[1mmy files\e[0;30m\033[0m";
        rclone sync -i -u --exclude-from "$exclude" "$from" "$to";
        echo -e "\e[0;33m\033[1mshared files\e[0;30m\033[0m";
        rclone sync -i -u --drive-shared-with-me \
            --exclude-from "$exclude" "$fromshared" "$toshared";;
    "dropbox_princeton")
        echo -e "\e[0;33m\033[1mmy files\e[0;30m\033[0m";
        rclone sync -i -u --exclude-from "$exclude" "$from" "$to";;
esac
