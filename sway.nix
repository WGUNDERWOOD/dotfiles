{pkgs, ...}: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
    };
    extraConfig =
      ''
        input type:keyboard {
          repeat_delay 200
	      repeat_rate 50
        }
      '';
  };
}
