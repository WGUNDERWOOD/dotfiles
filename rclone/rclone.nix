{pkgs, ...}: {
    # TODO put main rclone config in nix with secrets
    # TODO rclone include other remotes
    home.file."scripts/rclone_google_drive_pull.sh".source = ./rclone_google_drive_pull.sh;
    home.file.".config/rclone/rclone_excludes_google_drive.txt".source = ./rclone_excludes_google_drive.txt;
}
