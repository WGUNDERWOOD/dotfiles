{config, pkgs, lib, setEnvironment, ... }: {
    systemd.user = {

        services.mbsync = {
            Unit = {
                Description = "mbsync start";
                After = "network-online.target";
                WantedBy = "default.target";
            };
            Service = {
                Type = "oneshot";
                ExecStart = "/bin/sh /etc/profile; mbsync -a";
            };
        };

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
