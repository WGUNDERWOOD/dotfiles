{
  config,
  pkgs,
  lib,
  setEnvironment,
  ...
}: {
  systemd.user = {
    services.mbsync = {
      Unit = {
        Description = "mbsync start";
        After = "network-online.target";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.isync}/bin/mbsync -a && ${pkgs.coreutils}/bin/date +'%s' > $$HOME/tmp/mbsync_last_sync_time";
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
        OnBootSec = "30s";
        OnUnitActiveSec = "15s";
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };

    services.waybar = {
      Unit = {
        Description = "waybar";
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
  };
}
