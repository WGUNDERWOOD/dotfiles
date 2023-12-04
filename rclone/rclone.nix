{pkgs, ...}: {
    # TODO put main rclone config in nix with secrets
    # google drive
    home.file.".config/rclone/rclone_excludes_google_drive.txt".source = ./rclone_excludes_google_drive.txt;
    home.file."scripts/rclone_google_drive_pull.sh".source = ./rclone_google_drive_pull.sh;
    home.file."scripts/rclone_google_drive_push.sh".source = ./rclone_google_drive_push.sh;
    # google drive princeton
    home.file.".config/rclone/rclone_excludes_google_drive_princeton.txt".source = ./rclone_excludes_google_drive_princeton.txt;
    home.file."scripts/rclone_google_drive_princeton_pull.sh".source = ./rclone_google_drive_princeton_pull.sh;
    home.file."scripts/rclone_google_drive_princeton_push.sh".source = ./rclone_google_drive_princeton_push.sh;
    # dropbox princeton
    home.file.".config/rclone/rclone_excludes_dropbox_princeton.txt".source = ./rclone_excludes_dropbox_princeton.txt;
    home.file."scripts/rclone_dropbox_princeton_pull.sh".source = ./rclone_dropbox_princeton_pull.sh;
    home.file."scripts/rclone_dropbox_princeton_push.sh".source = ./rclone_dropbox_princeton_push.sh;
}
