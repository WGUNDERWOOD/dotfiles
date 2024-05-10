{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellApplication {
  name = "pulse-cycle";
  runtimeInputs = with pkgs; [bash coreutils pulseaudio];
  text = ''
    CURRENT_SINK="$(pactl list short sinks | grep RUNNING | cut --fields 1)"
    SINKS="$(pactl list short sinks | grep "analog-stereo\|MOMENTUM_4")"
    SINKS="$(echo "$SINKS" | cut --fields 1 | tr "\n" " ")"
    NEXT_SINK="$(echo "$SINKS" | cut --delimiter=" " --fields 1)"
    NUM_SINKS="$(echo "$SINKS" | wc -w)"

    for I in $(seq 1 $((NUM_SINKS-1))); do
        SINK="$(echo "$SINKS" | cut --delimiter=" " --fields "$I")"
        if [[ "$SINK" == "$CURRENT_SINK" ]]; then
            NEXT_SINK="$(echo "$SINKS" | cut --delimiter=" " --fields $((I+1)))"
        fi
    done

    echo "Available sinks: $SINKS"
    echo "Current sink ID: $CURRENT_SINK"
    echo "Next sink ID: $NEXT_SINK"

    echo "Setting default sink to $NEXT_SINK"
    pactl set-default-sink "$NEXT_SINK"

    pactl list short sink-inputs | while read -r STREAM; do
        STREAM_ID=$(echo "$STREAM" | cut --fields 1)
        echo "Moving stream $STREAM_ID to sink $NEXT_SINK"
        pactl move-sink-input "$STREAM_ID" "$NEXT_SINK"
    done
  '';
}
