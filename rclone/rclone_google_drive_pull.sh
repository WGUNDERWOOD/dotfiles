#!/usr/bin/env bash

EXCLUDE="$HOME/.config/rclone/rclone_excludes_google_drive.txt"
NEAR="$HOME/rclone/google_drive/"
NEARSHARED="$HOME/rclone/google_drive/Shared/"
FAR="google_drive:"

echo -e "\e[0;35m\033[1mrclone pull Google Drive\e[0;30m\033[0m"

echo -e "\e[0;33m\033[1mmy files\e[0;30m\033[0m"
rclone sync -i -u --checkers 8 --exclude-from "$EXCLUDE" "$FAR" "$NEAR"

echo -e "\e[0;33m\033[1mshared files\e[0;30m\033[0m"
rclone sync -i -u --checkers 8 --drive-shared-with-me --exclude-from "$EXCLUDE" "$FAR" "$NEARSHARED"
