{osConfig, ...}: {
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

    colors = {
      draw_bold_text_with_bright_colors = true;
      primary = {
        background = "#181a26";
        foreground = "#f8f8f2";
        bright_foreground = "#ffffff";
      };
      cursor = {
        text = "CellBackground";
        cursor = "CellForeground";
      };
      vi_mode_cursor = {
        text = "CellBackground";
        cursor = "CellForeground";
      };
      search = {
        matches = {
          foreground = "#44475a";
          background = "#50fa7b";
        };
        focused_match = {
          foreground = "#44475a";
          background = "#ffb86c";
        };
      };
      footer_bar = {
        background = "#181a26";
        foreground = "#f8f8f2";
      };
      hints = {
        start = {
          foreground = "#181a26";
          background = "#f1fa8c";
        };
        end = {
          foreground = "#f1fa8c";
          background = "#181a26";
        };
      };
      line_indicator = {
        foreground = "None";
        background = "None";
      };
      selection = {
        text = "CellForeground";
        background = "#44475a";
      };
      normal = {
        black = "#21222c";
        red = "#ff5555";
        green = "#50fa7b";
        yellow = "#f1fa8c";
        blue = "#bd93f9";
        magenta = "#ff79c6";
        cyan = "#8be9fd";
        white = "#f8f8f2";
      };
      bright = {
        black = "#6272a4";
        red = "#ff6e6e";
        green = "#69ff94";
        yellow = "#ffffa5";
        blue = "#d6acff";
        magenta = "#ff92df";
        cyan = "#a4ffff";
        white = "#ffffff";
      };
    };
  };
}
