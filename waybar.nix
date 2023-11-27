{pkgs, lib, ...}: {
    programs.waybar.enable = true;
    programs.waybar.settings = {
        mainBar = {
            layer = "top";
            position = "bottom";
            height = 40;
            modules-left = [ "sway/workspaces" ];
            modules-center = [ ];
            modules-right = [ "memory" "cpu" "temperature" "network" "pulseaudio" "clock" ];

            memory = {
                interval = 10;
                format = "Mem {percentage}%";
            };

            cpu = {
                interval = 5;
                format = "CPU {usage}% {icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
                format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
            };

            temperature = {
                format = "{temperatureC}C";
            };

            network = {
                format = "Net {signalStrength}";
            };

            pulseaudio = {
                format = "Vol {volume}";
            };

            clock = {
                format = "{:%H:%M %a %d %h %Y}";
            };

        };
    };
    programs.waybar.style = ''
        * {
            border: none;
            border-radius: 0;
            font-family: "Source Code Pro";
            font-size: 16px;
            min-height: 0;
        }
    '';
}
