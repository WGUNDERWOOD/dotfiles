{pkgs, ...}: {
  home.file.".config/rofi/config.rasi".source = ./config.rasi;
  home.file.".config/rofi/rofi_tasks.json".source = ./rofi_tasks.json;
}
