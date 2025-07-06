{osConfig, ...}: {
  home.file.".config/alacritty/catppuccin-mocha.toml".source = ./catppuccin-mocha.toml;
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    scrolling.history = 10000;

    font = {
      normal.family = "Source Code Pro";
      size =
        if osConfig.networking.hostName == "libra"
        then 12.0
        else 14.0;
    };

    cursor.style = {
      shape = "Block";
      blinking = "On";
    };

    general.import = [
      "~/.config/alacritty/catppuccin-mocha.toml"
    ];

    colors.draw_bold_text_with_bright_colors = true;
  };
}
