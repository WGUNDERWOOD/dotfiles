{...}: {
  programs.feh = {
    enable = true;
    keybindings = {
      zoom_in = "i";
      zoom_out = "u";
      zoom_fit = "a";
      zoom_default = "s";
      scroll_left = "h";
      scroll_right = "l";
      scroll_up = "k";
      scroll_down = "j";
      toggle_info = "t";
    };
  };
}
