{
  pkgs,
  osConfig,
  ...
}: {
  programs.waybar.enable = true;
  programs.waybar.settings.mainbar = {
    position = "bottom";
    height =
      if osConfig.networking.hostName == "libra"
      then 40
      else 50;
    modules-left = [
      "sway/workspaces"
      "custom/separatorleft"
      "custom/spotify"
    ];
    "modules-center" = [];
    "modules-right" = (
      if osConfig.networking.hostName == "libra"
      then
        # libra modules right
        [
          "memory"
          "custom/separator"
          "cpu"
          "custom/separator"
          "disk"
          "custom/separator"
          "pulseaudio"
          "custom/separator"
          "custom/mail"
          "custom/separator"
          "custom/gammastep"
          "custom/separator"
          "network"
          "custom/separator"
          "clock#time"
          "custom/separator"
          "clock#date"
        ]
      else
        # xanth modules right
        [
          "memory"
          "custom/separator"
          "cpu"
          "custom/separator"
          "disk"
          "custom/separator"
          "pulseaudio"
          "custom/separator"
          "battery"
          "custom/separator"
          "custom/backlight"
          "custom/separator"
          "custom/mail"
          "custom/separator"
          "custom/gammastep"
          "custom/separator"
          "network"
          "custom/separator"
          "clock#time"
          "custom/separator"
          "clock#date"
        ]
    );
    "custom/separator" = {
      "format" = "|";
      "tooltip" = false;
    };
    "custom/separatorleft" = {
      "format" = "{}";
      "exec" = "echo '|'";
      "tooltip" = false;
      "interval" = 1;
      "exec-if" = "${pkgs.procps}/bin/pgrep spotify";
    };
    "sway/workspaces" = {
      "enable-bar-scroll" = true;
      "smooth-scrolling-threshold" = 2;
      "disable-markup" = true;
      "format" = "{icon}";
      "format-icons" = {"10" = "0";};
    };
    "clock#date" = {
      "format" = "{:%a %d %b %Y}";
      "on-click" = "${pkgs.firefox}/bin/firefox https://calendar.google.com";
    };
    "clock#time" = {
      "format" = "{:%H:%M}";
      "on-click" =
        "${pkgs.firefox}/bin/firefox "
        + "https://app.todoist.com/app/upcoming";
    };
    "cpu" = {
      "format" = "CPU {usage}%";
      "interval" = 10;
      "tooltip" = false;
      "on-click" =
        "${pkgs.alacritty}/bin/alacritty -e "
        + "'${pkgs.bottom}/bin/btm'";
    };
    "memory" = {
      "interval" = 10;
      "format" = "RAM {percentage}%";
      "tooltip" = false;
      "on-click" =
        "${pkgs.alacritty}/bin/alacritty -e "
        + "'${pkgs.bottom}/bin/btm'";
    };
    "custom/mail" = {
      "format" = "{}";
      "exec" =
        pkgs.writeShellScript "waybar-mail"
        ''
          CURRENT_TIME="$(${pkgs.coreutils}/bin/date +'%s')"
          LAST_SYNC_TIME="$(${pkgs.coreutils}/bin/cat \
              $HOME/tmp/mbsync_last_sync_time)"
          ELAPSED_TIME=$((CURRENT_TIME - LAST_SYNC_TIME))
          COUNT=$(${pkgs.findutils}/bin/find \
              ~/mail/gmail/INBOX/new/ \
              ~/mail/cambridge/INBOX/new/ \
              -type f | \
              ${pkgs.coreutils}/bin/wc -l)
          if (( "$ELAPSED_TIME" < 120 )); then
              if [ "$COUNT" -ge "1" ]; then
                  echo '{"text": "Mail '$COUNT'", "class": "new_mail"}'
              else
                  echo '{"text": "Mail", "class": "no_mail"}'
              fi
          else
              echo '{"text": "Mail", "class": "inactive"}'
          fi
        '';
      "restart-interval" = 10;
      "return-type" = "json";
    };
    "custom/gammastep" = {
      "exec" =
        pkgs.writeShellScript "waybar-gammastep"
        ''
          STATUS=$(${pkgs.coreutils}/bin/cat "$HOME/tmp/gammastatus")
          echo '{"text": "Gam", "class": "'$STATUS'"}'
        '';
      "restart-interval" = 10;
      "return-type" = "json";
    };
    "network" = {
      "format" = "Net";
      "tooltip" = false;
      "on-click" =
        "${pkgs.alacritty}/bin/alacritty -e "
        + "'${pkgs.bottom}/bin/btm'";
    };
    "custom/spotify" = {
      "format" = "{}";
      "interval" = 1;
      "max-length" = 50;
      "on-click" = "${pkgs.playerctl}/bin/playerctl previous";
      "on-click-right" = "${pkgs.playerctl}/bin/playerctl next";
      "on-click-middle" = "${pkgs.playerctl}/bin/playerctl play-pause";
      "exec" = ''
        ${pkgs.playerctl}/bin/playerctl -p spotify metadata -f '{{artist}}' | \
        ${pkgs.gnused}/bin/sed 's/&/&amp;/g'
      '';
      "exec-if" = "${pkgs.procps}/bin/pgrep spotify";
      "tooltip" = false;
    };
    "disk" = {
      "interval" = 60;
      "format" = "Disk {percentage_used}%";
      "path" = "/";
      "on-click" =
        "${pkgs.alacritty}/bin/alacritty -e "
        + "'${pkgs.bottom}/bin/btm'";
      "tooltip" = false;
    };
    "pulseaudio" = {
      "format" = "Vol {volume}%{icon}";
      "format-bluetooth" = "Vol {volume}% B";
      "format-muted" = "Mut {volume}%";
      "format-icons" = {
        "headphone" = " H";
        "headset" = " H";
        "phone" = " P";
        "default" = "";
      };
      "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
      "on-scroll-up" = "";
      "on-scroll-down" = "";
      "tooltip" = false;
    };
    "battery" = {
      "states" = {"warning" = 25;};
      "full-at" = 95;
      "format" = "Bat {capacity}%";
      "format-charging" = "Chg {capacity}%";
      "interval" = 10;
      "tooltip" = false;
    };
    "custom/backlight" = {
      "format" = "{}";
      "exec" =
        pkgs.writeShellScript "waybar-backlight"
        ''
          DISPLAY="$(${pkgs.sway}/bin/swaymsg -r -t get_outputs)"
          DISPLAY="$(echo $DISPLAY | ${pkgs.jq}/bin/jq \
              'map(select(.name=="eDP-1"))')"
          DISPLAY="$(echo $DISPLAY | ${pkgs.jq}/bin/jq '.[0] | .active')"
          if [ "$DISPLAY" == "true" ]; then
              BRIGHTNESS="$(${pkgs.brillo}/bin/brillo -G)"
              BRIGHTNESS="''${BRIGHTNESS%.*}"
              echo '{"text": "'Bkl $BRIGHTNESS%'", "class": "on"}'
          else
              echo '{"text": "'Bkl'", "class": "off"}'
          fi
        '';
      "return-type" = "json";
      "restart-interval" = 1;
    };
  };

  programs.waybar.style = let
    fontsize =
      if osConfig.networking.hostName == "libra"
      then "20px"
      else "24px";
    bordertoplarge =
      if osConfig.networking.hostName == "libra"
      then "3px"
      else "3px";
    bordertopsmall =
      if osConfig.networking.hostName == "libra"
      then "1px"
      else "1px";
    paddinglarge =
      if osConfig.networking.hostName == "libra"
      then "16px"
      else "18px";
    paddingmedium =
      if osConfig.networking.hostName == "libra"
      then "12px"
      else "14px";
    paddingsmall =
      if osConfig.networking.hostName == "libra"
      then "8px"
      else "10px";
    paddingtiny =
      if osConfig.networking.hostName == "libra"
      then "0px"
      else "1px";
    spotifyfontsize =
      if osConfig.networking.hostName == "libra"
      then "19px"
      else "23px";
    #color-crust = "#11111b";
    color-black = "#060609";
    color-overlay-2 = "#9399b2";
    color-surface-0 = "#313244";
    color-hot-pink = "#ffaaff";
    color-pink = "#f5c2e7";
    color-alert = "#ff713e";
    color-peach = "#fab387";
    color-yellow = "#f9e2af";
    color-sky = "#89dceb";
    color-green = "#a6e3a1";
    color-mauve = "#cba6f7";
  in ''
    * {
        font-family: "Source Code Pro";
        font-size: ${fontsize};
        background-color: ${color-black};
        border-top: ${bordertopsmall} solid ${color-black}
    }

    #workspaces {
        font-weight: 600;
        background-color: ${color-black};
    }

    #workspaces button {
        padding: 0px ${paddingsmall} ${paddingtiny} ${paddingsmall};
        border-radius: 1px;
        border-left: none;
        border-right: none;
        color: ${color-overlay-2};
        background-color: ${color-black};
    }

    #workspaces button.focused {
        border-bottom: ${bordertoplarge} solid ${color-hot-pink};
        border-top: ${bordertoplarge} solid ${color-black};
        border-left: none;
        border-right: none;
        color: ${color-hot-pink};
    }

    #workspaces button.urgent {
        border-left: none;
        border-right: none;
        color: ${color-overlay-2};
    }

    #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: none;
        border: inherit;
    }

    #workspaces button.focused:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: none;
        border-bottom: ${bordertoplarge} solid ${color-hot-pink};
        border-top: ${bordertoplarge} solid ${color-black};
        border-left: none;
        border-right: none;
    }

    #workspaces button.urgent:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background: none;
        border: inherit;
    }

    #clock.time {
        color: ${color-green};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #clock.date {
        color: ${color-mauve};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #cpu {
        color: ${color-pink};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #memory {
        color: ${color-yellow};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-mail.new_mail {
        color: ${color-hot-pink};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-mail.no_mail {
        color: ${color-pink};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-mail.inactive {
        color: ${color-alert};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-gammastep.day {
        color: ${color-sky};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-gammastep.night {
        color: ${color-peach};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #network.wifi, #network.ethernet {
        color: ${color-yellow};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #network.disabled, #network.disconnected {
        color: ${color-alert};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #pulseaudio, #pulseaudio.bluetooth {
        color: ${color-green};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #pulseaudio.muted {
        color: ${color-overlay-2};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #disk {
        color: ${color-sky};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #battery {
        color: ${color-mauve};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #battery.warning {
        color: ${color-alert};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #battery.charging.warning {
        color: ${color-mauve};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-backlight.on {
        color: ${color-yellow};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-backlight.off {
        color: ${color-yellow};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-spotify {
        color: ${color-green};
        font-size: ${spotifyfontsize};
        padding: 0px ${paddingsmall};
        font-weight: 500;
    }

    #custom-separator {
        color: ${color-surface-0};
        font-size: ${fontsize};
        font-weight: 600;
    }

    #custom-separatorleft {
        color: ${color-surface-0};
        font-size: ${fontsize};
        font-weight: 600;
        padding-left: ${paddingmedium};
        padding-right: ${paddinglarge};
    }
  '';
}
