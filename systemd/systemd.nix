{config, pkgs, lib, setEnvironment, ... }: {
    systemd.user = {

        services.waybar = {
            Unit = {
                Description = pkgs.waybar.meta.description;
                PartOf = ["graphical-session.target"];
            };
            Install = {
                WantedBy = ["sway-session.target"];
            };
            Service = {
                ExecStart = "${pkgs.waybar}/bin/waybar";
                RestartSec = 3;
                Restart = "always";
            };
        };
        # TODO mbsync
        #services.mbsync = {
            #description = "mbsync start";
            #serviceConfig = {
                #Type = "oneshot";
                #ExecStart = "${pkgs.isync}/bin/mbsync -a";
            #};
            #after = ["network-online.target"];
            #wantedBy = "default.target";
        #};

        #timers.mbsync = {
            #description = "mbsync timer";
            #timerConfig = {
                #OnBootSec = "2m";
                #OnUnitActiveSec = "2m";
                #Unit = "mbsync.service";
            #};
            #wantedBy = [ "timers.target" ];
        #};
    };
}
