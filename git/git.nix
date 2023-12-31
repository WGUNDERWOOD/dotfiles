{pkgs, ...}: {
    home.file.".gitconfig".source = ./.gitconfig;
    home.file."scripts/repos".source = ./repos;
}
