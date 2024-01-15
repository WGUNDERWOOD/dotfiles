{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
    enableFishIntegration = true;
  };
}
