{pkgs, ...}: {
    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.phinger-cursors;
        name = "phinger-cursors";
    };
}
