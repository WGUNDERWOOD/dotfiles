{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "gamma-toggle";
  runtimeInputs = with pkgs; [coreutils procps gammastep];
  text = ''
    status_file="$HOME/tmp/gammastatus"
    temp_night=2500
    temp_day=6500
    mkdir -p "$(dirname "$status_file")"
    touch "$status_file"
    current_status="$(cat "$status_file")"
    pkill gammastep || true
    if [ "$current_status" == "night" ]; then
        echo "day" > "$status_file"
        gammastep -PO "$temp_day"
    else
        echo "night" > "$status_file"
        gammastep -PO "$temp_night"
    fi
  '';
}
