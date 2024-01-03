{pkgs, lib, ...}: {
    programs.swaylock.enable = true;
    programs.swaylock.settings = {
        ignore-empty-password = true;
        indicator-radius = 120;
        indicator-thickness = 30;
        color = "181a26";
        inside-color = "1F202A";
        line-color = "1F202A";
        ring-color = "bd93f9";
        text-color = "00000000";
        layout-bg-color = "1F202A";
        layout-text-color = "00000000";
        inside-clear-color = "6272a4";
        line-clear-color = "1F202A";
        ring-clear-color = "6272a4";
        text-clear-color = "00000000";
        inside-ver-color = "8be9fd";
        line-ver-color = "1F202A";
        ring-ver-color = "6272a4";
        text-ver-color = "00000000";
        inside-wrong-color = "ff713e";
        line-wrong-color = "1F202A";
        ring-wrong-color = "ff713e";
        text-wrong-color = "00000000";
        bs-hl-color = "ff5555";
        key-hl-color = "50fa7b";
        text-caps-lock-color = "00000000";
    };
}
