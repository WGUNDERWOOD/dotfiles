{pkgs, lib, ...}: {
    home.file.".config/mimeapps.list".source = ./mimeapps.list;
}
