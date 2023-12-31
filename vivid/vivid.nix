{pkgs, ...}: {
    home.file.".config/vivid/filetypes.yml".source = ./filetypes.yml;
    home.file.".config/vivid/themes/dracula.yml".source = ./dracula.yml;
}
