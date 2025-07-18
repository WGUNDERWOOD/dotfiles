{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 1800;
        command =
          if osConfig.networking.hostName == "xanth"
          then "${pkgs.swaylock}/bin/swaylock -f"
          else "";
      }
      {
        timeout = 2400;
        command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\"";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command =
          if osConfig.networking.hostName == "xanth"
          then "${pkgs.swaylock}/bin/swaylock -f"
          else "";
      }
    ];
  };

  home.file.".local/share/icons/default".source =
    "${pkgs.phinger-cursors}/share/icons/"
    + "phinger-cursors-dark";

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      gaps.smartBorders = "on";
      window = {
        border = 2;
        titlebar = false;
      };
      bars = [];
      output =
        {"*" = {bg = "~/wallpaper.png fill";};}
        // (
          if osConfig.networking.hostName == "libra"
          then {
            "DP-1" = {
              pos = "0,0";
              res = "2560x1440";
              scale = "1";
            };
          }
          else {
            "eDP-1" = {
              pos = "0,0";
              res = "2560x1440";
              scale = "1.1";
            };
            "HDMI-A-1" = {
              pos = "0,0";
              res = "2560x1440";
              scale = "0.85";
            };
          }
        );

      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+f" = "exec firefox";
        "${modifier}+Shift+s" =
          "exec pgrep spotify || "
          + "((swaymsg workspace number 10 && spotify) & "
          + "(sleep 1 && rm -fd $HOME/Downloads/))";
        "${modifier}+d" = "exec rofi-start";
        "${modifier}+Shift+Ctrl+k" =
          if osConfig.networking.hostName == "xanth"
          then "exec \"swaylock -f && systemctl suspend\""
          else "exec \"systemctl suspend\"";
        "${modifier}+Shift+Ctrl+l" = "exec \"swaylock -f\"";
        "${modifier}+p" = "kill";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+b" = "split h";
        "${modifier}+v" = "split v";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        "${modifier}+o" = "exec sway-empty -g";
        "${modifier}+Shift+o" = "exec sway-empty -m";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+u" = "resize shrink width 3 px or 3 ppt";
        "${modifier}+i" = "resize grow width 3 px or 3 ppt";
        "${modifier}+m" = "workspace next";
        "${modifier}+n" = "workspace prev";
        "${modifier}+Shift+m" = "move container to workspace next";
        "${modifier}+Shift+n" = "move container to workspace prev";
        "${modifier}+s" =
          "exec grim -g \"$(slurp)\" "
          + "~/screenshots/screenshot_$(date -u +%Y-%m-%d_%H-%m-%S).png | "
          + "wl-copy -t image/png";
        "${modifier}+g" = "exec gamma-toggle";
        "${modifier}+Right" = "exec playerctl next";
        "${modifier}+Left" = "exec playerctl previous";
        "${modifier}+space" = "exec playerctl play-pause";
        "${modifier}+c" = "exec pulse-cycle";
        "${modifier}+Down" =
          "exec \"pactl set-sink-volume "
          + "@DEFAULT_SINK@ -5%\"";
        "${modifier}+Up" = "exec \"pactl set-sink-volume @DEFAULT_SINK@ +5%\"";
        "XF86AudioLowerVolume" =
          "exec \"pactl set-sink-volume "
          + "@DEFAULT_SINK@ -5%\"";
        "XF86AudioRaiseVolume" =
          "exec \"pactl set-sink-volume "
          + "@DEFAULT_SINK@ +5%\"";
        "XF86AudioMute" = "exec \"pactl set-sink-mute @DEFAULT_SINK@ toggle\"";
        "XF86AudioMicMute" =
          "exec \"pactl set-source-mute "
          + "@DEFAULT_SOURCE@ toggle\"";
        "XF86MonBrightnessUp" = "exec \"brillo -A 5\"";
        "XF86MonBrightnessDown" = "exec \"brillo -U 5\"";
        "Shift+XF86MonBrightnessUp" = "exec \"brillo -S 100\"";
        "Shift+XF86MonBrightnessDown" = "exec \"brillo -S 10\"";
        "XF86Display" = "exec \"sway output eDP-1 toggle\"";
      };

      colors = {
        focused = {
          border = "#f5c2e7";
          background = "#f5c2e7";
          text = "#cdd6f4";
          indicator = "#f5c2e7";
          childBorder = "#f5c2e7";
        };
        focusedInactive = {
          border = "#11111b";
          background = "#11111b";
          text = "#cdd6f4";
          indicator = "#11111b";
          childBorder = "#11111b";
        };
        unfocused = {
          border = "#11111b";
          background = "#11111b";
          text = "#6c7086";
          indicator = "#11111b";
          childBorder = "#11111b";
        };
        urgent = {
          border = "#11111b";
          background = "#11111b";
          text = "#cdd6f4";
          indicator = "#11111b";
          childBorder = "#11111b";
        };
        placeholder = {
          border = "#11111b";
          background = "#11111b";
          text = "#6c7086";
          indicator = "#11111b";
          childBorder = "#11111b";
        };
      };
    };

    extraConfig = ''
      seat * hide_cursor 1800
      seat * hide_cursor when-typing enable
      for_window [class=".*"] inhibit_idle fullscreen
      for_window [app_id=".*"] inhibit_idle fullscreen
      input type:keyboard {
          repeat_delay 200
          repeat_rate 50
      }
      input type:touchpad {
          pointer_accel 0.5
          natural_scroll enabled
      }
      exec echo "day" > $HOME/tmp/gammastatus
      exec "pactl set-sink-volume @DEFAULT_SINK@ 30%"
      exec "swaylock -f"
      exec "swaymsg workspace 1"
    '';
  };
}
