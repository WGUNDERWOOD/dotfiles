{pkgs, ...}: {
    programs.feh = {
        enable = true;
        keybindings = {
            zoom_in = "i";
            zoom_out = "u";
            zoom_fit = "s";
            zoom_default = "a";
            scroll_left = "h";
            scroll_right = "l";
            scroll_up = "k";
            scroll_down = "j";
        };
    };
}
