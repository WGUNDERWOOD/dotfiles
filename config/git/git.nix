{pkgs, ...}: {
  home.file.".config/git/config".source = ./.gitconfig;
  home.file.".gitattributes".source = ./.gitattributes;
}
