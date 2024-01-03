{pkgs, ...}: {
    home.file.".config/rclone/rclone_excludes_google_drive.txt".source =
        ./rclone_excludes_google_drive.txt;
    home.file.".config/rclone/rclone_excludes_google_drive_princeton.txt".source =
        ./rclone_excludes_google_drive_princeton.txt;
    home.file.".config/rclone/rclone_excludes_dropbox_princeton.txt".source =
        ./rclone_excludes_dropbox_princeton.txt;
}
