{pkgs, lib, ...}: {
    programs.waybar.enable = true;
    # TODO copy everything here
    #home.file.".config/waybar/config".source = ./config;
    #home.file.".config/waybar/style.css".source = ./style.css;
}
