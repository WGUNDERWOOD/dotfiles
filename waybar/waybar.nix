{pkgs, ...}: {
    programs.waybar.enable = true;
    home.file.".config/waybar/config".source = ./config;
    home.file.".config/waybar/style.css".source = ./style.css;
    home.file."scripts/waybar_gammastep".source = ./waybar_gammastep;
    home.file."scripts/waybar_mail".source = ./waybar_mail;
}
