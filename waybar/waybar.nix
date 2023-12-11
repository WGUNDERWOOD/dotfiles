{pkgs, ...}: {
    programs.waybar.enable = true;
#home.file.".config/waybar/config".source = ./config;
#home.file.".config/waybar/style.css".source = ./style.css;
#home.file."scripts/waybar_gammastep".source = ./waybar_gammastep;
#home.file."scripts/waybar_mail".source = ./waybar_mail;
#home.file."scripts/waybar_repos".source = ./waybar_repos;
# TODO format this better
    programs.waybar.settings = {
        mainbar = {
            position = "bottom";
            height = 40;
            "modules-left" = [
                "sway/workspaces"
                    "custom/separatorleft"
                    "custom/spotify"];
            "modules-center" = [];
            "modules-right" = [
                "memory"
                    "custom/separator"
                    "cpu"
                    "custom/separator"
                    "disk"
                    "custom/separator"
                    "custom/repos"
                    "custom/separator"
                    "temperature"
                    "custom/separator"
                    "custom/mail"
                    "custom/separator"
                    "custom/gammastep"
                    "custom/separator"
                    "network"
                    "custom/separator"
                    "pulseaudio"
                    "custom/separator"
                    "clock#time"
                    "custom/separator"
                    "clock#date"
                    ];
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
                "format-icons" = { "10" = "0"; };
            };
            "clock#date" = {
                "format" = "{:%a %d %b %Y}";
            };
            "clock#time" = {
                "format" = "{:%H:%M}";
            };
            "cpu" = {
                "format" = "CPU {usage}%";
                "interval" = 10;
                "tooltip" = false;
            };
            "memory" = {
                "interval" = 10;
                "format" = "RAM {percentage}%";
                "tooltip" = false;
            };
            "temperature" = {
                "critical-threshold" = 80;
                "format-critical" = "{temperatureC}°C";
                "format" = "{temperatureC}°C";
                "tooltip" = false;
            };
            "custom/mail" = {
                "format" = "{}";
                "exec" = pkgs.writeShellScript "waybar-mail"
                ''
                STATUS=$(systemctl is-active --user mbsync.timer)
                COUNT=$(${pkgs.findutils}/bin/find \
                ~/mail/princeton/INBOX/new/ ~/mail/gmail/INBOX/new/ -type f | \
                ${pkgs.coreutils}/bin/wc -l)
                if [ "$STATUS" = "active" ]; then
                    if [ "$COUNT" -ge "1" ]; then
                        echo '{"text": "Mail '$COUNT'", "class": "new_mail"}'
                    else
                        echo '{"text": "Mail", "class": "no_mail"}'
                    fi
                else
                    echo '{"text": "Mail", "class": "inactive"}'
                fi
                '';
                "restart-interval" = 120;
                "return-type" = "json";
            };
            "custom/gammastep" = {
                "exec" = pkgs.writeShellScript "waybar-gammastep"
                ''
                STATUS=$(${pkgs.coreutils}/bin/cat "$HOME/tmp/gammastatus")
                echo '{"text": "Gam", "class": "'$STATUS'"}'
                '';
                "restart-interval" = 10;
                "return-type" = "json";
            };
            "custom/repos" = {
                "exec" = pkgs.writeShellScript "waybar-repos"
                ''
                GITDIRS="$HOME/github/ $HOME/overleaf/"
                STATUS=$(${pkgs.findutils}/bin/find \
                $GITDIRS -maxdepth 1 -mindepth 1 -type d -exec \
                ${pkgs.bash}/bin/bash -c \
                'cd {} && [ -d .git/ ] && \
                [[ -n $(${pkgs.git}/bin/git status -s) ]] && pwd' \
                \; | ${pkgs.coreutils}/bin/wc -l)
                if [ "$STATUS" -ge "1" ]; then
                    echo '{"text": "Git '$STATUS'", "class": "dirty"}'
                else
                    echo '{"text": "Git", "class": "clean"}'
                fi
                '';
                "restart-interval" = 60;
                "return-type" = "json";
            };
            "network" = {
                "format" = "Net";
                "tooltip" = false;
            };
            "custom/spotify" = {
                "format" = "{}";
                "interval" = 1;
                "max-length" = 50;
                "on-click" = "${pkgs.playerctl}/bin/playerctl previous";
                "on-click-right" = "${pkgs.playerctl}/bin/playerctl next";
                "on-click-middle" = "${pkgs.playerctl}/bin/playerctl play-pause";
                "exec" = ''
                    ${pkgs.playerctl}/bin/playerctl metadata -f '{{artist}}' | \
                    ${pkgs.gnused}/bin/sed 's/&/&amp;/g'
                    '';
                "exec-if" = "${pkgs.procps}/bin/pgrep spotify";
                "tooltip" = false;
            };
            "disk" = {
                "interval" = 60;
                "format" = "Disk {percentage_used}%";
                "path" = "/";
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
                "on-click" = "pavucontrol";
                "tooltip" = false;
            };
            "battery" = {
                "states" = {
                    "good" = 95;
                    "warning" = 30;
                    "critical" = 15;
                };
                "format" = "{capacity}% {icon}";
                "format-icons" = ["" "" "" "" ""];
            };
            "backlight" = {
                "format" = "{percent}% {icon}";
                "format-icons" = [""];
                "on-scroll-up" = "brillo -A 0.5";
                "on-scroll-down" = "brillo -U 0.5";
            };
        };
    };

    programs.waybar.style =
        ''
        * {
            font-family: "Source Code Pro";
            font-size: 20px;
            background-color: #000000;
        }

#workspaces {
    font-weight: 600;
    background-color: #000000;
}

#workspaces button {
padding: 0px 8px;
         border-radius: 1px;
         border-left: none;
         border-right: none;
color: #8298c4;
       background-color: #000000;
}

#workspaces button.focused {
    border-bottom: 3px solid #ffaaff;
    border-top: 3px solid #000000;
    border-left: none;
    border-right: none;
color: #ffaaff;
}

#workspaces button.urgent {
    border-left: none;
    border-right: none;
color: #ff713e;
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
            border-bottom: 3px solid #ffaaff;
            border-top: 3px solid #000000;
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
color: #ffccdd;
padding: 0px 16px;
         font-weight: 500;
}

#clock.date {
color: #bbeeff;
padding: 0px 16px;
         font-weight: 500;
}

#cpu {
color: #ddbbff;
padding: 0px 16px;
         font-weight: 500;
}

#memory {
color: #bbeeff;
padding: 0px 16px;
         font-weight: 500;
}

#temperature {
color: #aaffcc;
padding: 0px 16px;
         font-weight: 500;
}

#temperature.critical {
color: #ff713e;
padding: 0px 16px;
         font-weight: 500;
}

#custom-mail.new_mail {
color: #ffaaff;
padding: 0px 16px;
         font-weight: 500;
}

#custom-mail.no_mail {
color: #ffccdd;
padding: 0px 16px;
         font-weight: 500;
}

#custom-mail.inactive {
color: #ff713e;
padding: 0px 16px;
         font-weight: 500;
}

#custom-gammastep.day {
color: #bbeeff;
padding: 0px 16px;
         font-weight: 500;
}

#custom-gammastep.night {
color: #ffb86c;
padding: 0px 16px;
         font-weight: 500;
}

#custom-repos.dirty {
color: #ffaaff;
padding: 0px 16px;
         font-weight: 500;
}

#custom-repos.clean {
color: #ffccdd;
padding: 0px 16px;
         font-weight: 500;
}

#network.wifi, #network.ethernet {
color: #ffccdd;
padding: 0px 16px;
         font-weight: 500;
}

#network.disabled, #network.disconnected {
color: #ff713e;
padding: 0px 16px;
         font-weight: 500;
}

#pulseaudio, #pulseaudio.bluetooth {
color: #aaffcc;
padding: 0px 16px;
         font-weight: 500;
}

#pulseaudio.muted {
color: #8298c4;
padding: 0px 16px;
         font-weight: 500;
}

#disk {
color: #f1faac;
padding: 0px 16px;
         font-weight: 500;
}

#custom-spotify {
color: #8adfac;
       font-size: 19px;
padding: 0px 8px;
         font-weight: 500;
}

#custom-separator {
color: #34374a;
       font-size: 20px;
       font-weight: 600;
}

#custom-separatorleft {
color: #34374a;
       font-size: 20px;
       font-weight: 600;
       padding-left: 12px;
       padding-right: 16px;
}
'';
}
