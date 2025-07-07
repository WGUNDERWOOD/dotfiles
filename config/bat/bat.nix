{...}: {
  home.file.".config/bat/themes/catppuccin_mocha.tmTheme".source = ./catppuccin_mocha.tmTheme;
  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin_mocha";
    };
  };
}
