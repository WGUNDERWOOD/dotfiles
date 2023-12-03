{pkgs, ...}: {
    # TODO put main rclone config in nix with secrets
    # TODO rclone include other remotes
    home.file.".config/rclone/rclone_excludes_google_drive.txt".source = ./rclone_excludes_google_drive.txt;
    home.file.".config/rclone/rclone_excludes_google_drive_princeton.txt".source = ./rclone_excludes_google_drive_princeton.txt;
    home.file."scripts/rclone_google_drive_pull.sh".source = ./rclone_google_drive_pull.sh;
    home.file."scripts/rclone_google_drive_push.sh".source = ./rclone_google_drive_push.sh;
    home.file."scripts/rclone_google_drive_princeton_pull.sh".source = ./rclone_google_drive_princeton_pull.sh;
    home.file."scripts/rclone_google_drive_princeton_push.sh".source = ./rclone_google_drive_princeton_push.sh;
}
