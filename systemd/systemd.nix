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
        };

        timers.mbsync = {
            Unit = {
                description = "mbsync timer";
            };
            Timer = {
                OnBootSec = "1m";
                OnUnitActiveSec = "1m";
            };
        };
    };
}
