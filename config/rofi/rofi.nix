{pkgs, ...}: {
    home.file.".config/rofi/config.rasi".source = ./config.rasi;
    home.file.".config/rofi/rofi_tasks.json".source = ./rofi_tasks.json;
    # TODO build this package rather than link as a script
    home.file."scripts/rofi-start".source = ../../programs/rofi-start/rofi-start;
}
