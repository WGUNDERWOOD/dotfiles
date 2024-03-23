{pkgs, ...}: {
  home.file.".gitconfig".source = ./.gitconfig;
  home.file.".gitattributes".source = ./.gitattributes;
}
