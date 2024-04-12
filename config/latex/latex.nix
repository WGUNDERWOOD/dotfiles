{pkgs, ...}: {
  home.file.".config/latexmk/.latexmkrc".source = ./.latexmkrc;
  home.file.".indentsettings.yaml".source = ./.indentsettings.yaml;
  home.file.".indentconfig.yaml".text = ''
    paths:
    - /home/will/.indentsettings.yaml
  '';
}
