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
        ExecStart =
          "${pkgs.bash}/bin/bash -c \" "
          + "${pkgs.isync}/bin/mbsync -a && "
          + " ${pkgs.coreutils}/bin/date +\\'%%s\\'"
          + " > /home/will/tmp/mbsync_last_sync_time \" ";
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

    services.davmail = {
      Unit = {
        Description = "davmail";
        After = "network-online.target";
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Service = {
        ExecStartPre = let
          davmailOauth = pkgs.callPackage ../programs/davmail-oauth.nix {};
        in "${davmailOauth}/bin/davmail-oauth";
        ExecStart = let
          davmailConfig = "/home/will/.config/davmail/davmail.conf";
        in "${pkgs.davmail}/bin/davmail ${davmailConfig}";
        RestartSec = 20;
        Restart = "always";
        RemainAfterExit = "true";
      };
    };
  };
}
