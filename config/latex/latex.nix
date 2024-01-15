{pkgs, ...}: {
  home.file.".latexmkrc".source = ./.latexmkrc;
  home.file.".indentsettings.yaml".source = ./.indentsettings.yaml;
  home.file.".indentconfig.yaml".text = ''
    paths:
    - /home/will/.indentsettings.yaml
  '';
}
