{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "sway-dpi";
  runtimeInputs = with pkgs; [jq sway];
  text = ''
    OUTPUT="DP-3"
    SCALE=$(swaymsg -t get_outputs | jq -r ".[] | select(.name == \"$OUTPUT\") | .scale")
    if [[ "$SCALE" == "1.0" ]]; then
        swaymsg "output $OUTPUT scale 1.4"
    else
        swaymsg "output $OUTPUT scale 1.0"
    fi
  '';
}
