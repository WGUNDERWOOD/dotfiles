{config, pkgs, lib, setEnvironment, ... }: {
    systemd.user = {

        services.mbsync = {
            Unit = {
                Description = "mbsync start";
                After = "network-online.target";
            };
            Service = {
                Type = "oneshot";
                ExecStart = "${pkgs.isync}/bin/mbsync -a";
            };
            Install = {
                WantedBy = ["default.target"];
            };
        };

        timers.mbsync = {
            Unit = {
                Description = "mbsync timer";
            };
            Timer = {
                OnBootSec = "1m";
                OnUnitActiveSec = "1m";
            };
            Install = {
                WantedBy = ["timers.target"];
            };
        };
    };
}
