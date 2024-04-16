{pkgs, ...}: {
  home.file.".config/git/config".source = ./.gitconfig;
  home.file.".config/git/.gitattributes".source = ./.gitattributes;
}
