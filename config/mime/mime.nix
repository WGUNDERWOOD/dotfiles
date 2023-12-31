{pkgs, lib, ...}: {
    home.file.".config/mimeapps.list".text = ''
        [Default Applications]
        application/pdf=org.pwmt.zathura.desktop
        image/*=feh.desktop
        '';
}
