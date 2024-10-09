{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "blur-wallpaper";
  runtimeInputs = with pkgs; [imagemagick coreutils];
  text = ''
    # pass radius as argument e.g. 50
    if ! [[ $1 =~ [0-9]+ ]]; then
        echo "Invalid radius"
        exit 1
    fi
    WALLPAPER="$HOME/wallpaper.png"
    WALLPAPER_BLUR="$HOME/wallpaper_blur.png"
    RADIUS="$1"
    magick "$WALLPAPER" -blur 0,"$RADIUS" "$WALLPAPER_BLUR"
  '';
}
