{config, pkgs, lib, setEnvironment, ... }: {
  systemd.user.services = {
    waybar = {
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
  };
}
