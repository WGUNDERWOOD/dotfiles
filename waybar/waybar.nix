{pkgs, lib, ...}: {
    programs.waybar.enable = true;
    home.file.".config/waybar/config".source = ./config;
    home.file.".config/waybar/style.css".source = ./style.css;
    home.file.".config/scripts/waybar_gammastep".source = ./waybar_gammastep;
    home.file.".config/scripts/waybar_mail".source = ./waybar_mail;
}
