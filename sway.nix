{pkgs, lib, ...}: {
    wayland.windowManager.sway = {

        enable = true;

        config = rec {
            modifier = "Mod4";
            terminal = "alacritty";
            window = {border = 2; titlebar = false;};
            bars = [];
            output."*".bg = "~/wallpaper.png fill";

            keybindings = lib.mkOptionDefault {
                "${modifier}+Shift+f" = "exec firefox";
                "${modifier}+Shift+Ctrl+k" = "exec \"shutdown now\"";
                "${modifier}+Shift+Ctrl+r" = "exec \"reboot\"";
                "${modifier}+Shift+Ctrl+l" = "exec \"swaylock -f -c 000000\"";
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
                "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" " +
                    "~/screenshots/screenshot_$(date -u +%Y-%m-%d_%H-%m-%S).png | " +
                    "wl-copy -t image/png";
                #"XF86MonBrightnessUp" = "exec \"brillo -A 1\"";
                #"XF86MonBrightnessDown" = "exec \"brillo -U 1\"";
                #"XF86AudioLowerVolume" = "exec \"pactl set-sink-volume 0 -5%\"";
                #"XF86AudioRaiseVolume" = "exec \"pactl set-sink-volume 0 +5%\"";
                #"XF86AudioPlay" = "exec \"playerctl play\"";
                #"XF86AudioPause" = "exec \"playerctl pause\"";
                #"XF86AudioNext" = "exec \"playerctl next\"";
                #"XF86AudioPrev" = "exec \"playerctl previous\"";
                #"${modifier}+Ctrl+s" = "exec \"swaylock -f -c 000000 && systemctl suspend\"";
            };

            colors = {
                focused = {
                    border = "#ffa9e6";
                    background = "#ffa9e6";
                    text = "#f8f8f2";
                    indicator = "#ffa9e6";
                    childBorder =  "#ffa9e6";
                };
                focusedInactive = {
                    border = "#000000";
                    background = "#000000";
                    text = "#f8f8f2";
                    indicator = "#000000";
                    childBorder =  "#000000";
                };
                unfocused = {
                    border = "#000000";
                    background = "#000000";
                    text = "#888888";
                    indicator = "#000000";
                    childBorder =  "#000000";
                };
                urgent = {
                    border = "#ff8833";
                    background = "#ff8833";
                    text = "#f8f8f2";
                    indicator = "#ff8833";
                    childBorder =  "#ff8833";
                };
                placeholder = {
                    border = "#000000";
                    background = "#000000";
                    text = "#888888";
                    indicator = "#000000";
                    childBorder =  "#000000";
                };
            };
        };

        extraConfig =
            ''
            input type:keyboard {
                repeat_delay 200
                    repeat_rate 50
            }
            workspace 1
        '';
    };

}
