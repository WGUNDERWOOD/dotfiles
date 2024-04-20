{pkgs, ...}: {
  home.file."$JULIA_DEPOT_PATH/artifacts/Overrides.toml".source = ./Overrides.toml;
}
