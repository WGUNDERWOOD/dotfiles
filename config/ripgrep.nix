{
  pkgs,
  lib,
  ...
}: {
  home.file.".config/.ripgreprc".text = ''
    --max-columns=150
    --max-columns-preview
    --smart-case
  '';
}
