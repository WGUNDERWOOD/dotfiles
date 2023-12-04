#!/usr/bin/env bash

EXCLUDE="$HOME/.config/rclone/rclone_excludes_dropbox_princeton.txt"
NEAR="$HOME/rclone/dropbox_princeton/"
FAR="dropbox_princeton:"

echo -e "\e[0;35m\033[1mrclone pull Dropbox Princeton\e[0;30m\033[0m"
rclone sync -i -u --checkers 8 --exclude-from "$EXCLUDE" "$FAR" "$NEAR"
