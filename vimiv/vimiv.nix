{pkgs, ...}: {
    home.file.".config/vimiv/vimivrc".source = ./vimivrc;
    home.file.".config/vimiv/keys.conf".source = ./keys.conf;
}
