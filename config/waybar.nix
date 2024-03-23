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
          "backlight"
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
    };
    "custom/separatorleft" = {
      "format" = "{}";
      "exec" = "echo '|'";
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
      "on-click" = "${pkgs.firefox}/bin/firefox https://app.todoist.com/app/upcoming";
    };
    "cpu" = {
      "format" = "CPU {usage}%";
      "interval" = 10;
      "tooltip" = false;
      "on-click" = "${pkgs.alacritty}/bin/alacritty -e '${pkgs.bottom}/bin/btm'";
    };
    "memory" = {
      "interval" = 10;
      "format" = "RAM {percentage}%";
      "tooltip" = false;
      "on-click" = "${pkgs.alacritty}/bin/alacritty -e '${pkgs.bottom}/bin/btm'";
    };
    "custom/mail" = {
      "format" = "{}";
      "exec" =
        pkgs.writeShellScript "waybar-mail"
        ''
          CURRENT_TIME=$(${pkgs.coreutils}/bin/date +'%s')
          LAST_SYNC_TIME=$(${pkgs.coreutils}/bin/cat $HOME/tmp/mbsync_last_sync_time)
          ELAPSED_TIME=$((CURRENT_TIME - LAST_SYNC_TIME))
          COUNT=$(${pkgs.findutils}/bin/find \
                  ~/mail/princeton/INBOX/new/ ~/mail/gmail/INBOX/new/ -type f | \
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
      "on-click" = "${pkgs.alacritty}/bin/alacritty -e '${pkgs.bottom}/bin/btm'";
    };
    "custom/spotify" = {
      "format" = "{}";
      "interval" = 1;
      "max-length" = 50;
      "on-click" = "${pkgs.playerctl}/bin/playerctl -p spotify previous";
      "on-click-right" = "${pkgs.playerctl}/bin/playerctl -p spotify next";
      "on-click-middle" = "${pkgs.playerctl}/bin/playerctl -p spotify play-pause";
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
      "on-click" = "${pkgs.alacritty}/bin/alacritty -e '${pkgs.bottom}/bin/btm'";
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
      "interval" = 30;
    };
    "backlight" = {
      "format" = "Bkl {percent}%";
    };
  };

  programs.waybar.style = let
    fontsize =
      if osConfig.networking.hostName == "libra"
      then "20.0"
      else "24.0";
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
    color-black = "#000000";
    color-mid-gray = "#8298c4";
    color-dark-gray = "#34374a";
    color-hot-pink = "#ffaaff";
    color-alert = "#ff713e";
    color-night = "#ffb86c";
    color-pastel-yellow = "#f4f5cc";
    color-pastel-pink = "#f8ceeb";
    color-pastel-blue = "#a8e4ec";
    color-pastel-green = "#a9f4b0";
    color-pastel-purple = "#dfc2ff";
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
        color: ${color-mid-gray};
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
        color: ${color-alert};
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
        color: ${color-pastel-green};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #clock.date {
        color: ${color-pastel-purple};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #cpu {
        color: ${color-pastel-pink};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #memory {
        color: ${color-pastel-yellow};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-mail.new_mail {
        color: ${color-hot-pink};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-mail.no_mail {
        color: ${color-pastel-pink};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-mail.inactive {
        color: ${color-alert};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-gammastep.day {
        color: ${color-pastel-blue};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-gammastep.night {
        color: ${color-night};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #network.wifi, #network.ethernet {
        color: ${color-pastel-yellow};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #network.disabled, #network.disconnected {
        color: ${color-alert};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #pulseaudio, #pulseaudio.bluetooth {
        color: ${color-pastel-green};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #pulseaudio.muted {
        color: ${color-mid-gray};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #disk {
        color: ${color-pastel-blue};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #battery {
        color: ${color-pastel-purple};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #battery.warning {
        color: ${color-alert};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #battery.charging.warning {
        color: ${color-pastel-purple};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #backlight {
        color: ${color-pastel-yellow};
        padding: 0px ${paddinglarge};
        font-weight: 500;
    }

    #custom-spotify {
        color: ${color-pastel-green};
        font-size: ${spotifyfontsize};
        padding: 0px ${paddingsmall};
        font-weight: 500;
    }

    #custom-separator {
        color: ${color-dark-gray};
        font-size: ${fontsize};
        font-weight: 600;
    }

    #custom-separatorleft {
        color: ${color-dark-gray};
        font-size: ${fontsize};
        font-weight: 600;
        padding-left: ${paddingmedium};
        padding-right: ${paddinglarge};
    }
  '';
}
