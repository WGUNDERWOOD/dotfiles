#!/usr/bin/env bash

config="$HOME/.config/rofi/rofi_tasks.yml"
tasks="$(cat "$config")"
selected="$(echo "$tasks" | yq -j 'map(.name) | join("\n")' | \
    rofi -dmenu -matching fuzzy -i -p "Run")"
task="$(echo "$tasks" | yq ".[] | select(.name == \"$selected\")")"
[[ -z "$task" ]] && exit 1
task_command="$(echo "$task" | yq ".command")"
eval "\"$task_command\" > /dev/null &"
