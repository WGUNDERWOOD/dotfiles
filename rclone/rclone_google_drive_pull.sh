#!/usr/bin/env bash

echo -e "\e[0;35m\033[1mrclone pull Google Drive\e[0;30m\033[0m"

# my files
rclone sync -i -u \
    --exclude-from /home/will/github/dotfiles/rclone/rclone_excludes_google_drive.txt \
    google_drive: \
    ~/rclone/google_drive/

# shared files
rclone sync -i -u --drive-shared-with-me \
    --exclude-from /home/will/github/dotfiles/rclone/rclone_excludes_google_drive.txt \
    google_drive: \
    ~/rclone/google_drive/Shared/
