#!/usr/bin/env bash

config="$HOME/.config/rofi/rofi_tasks.json"
tasks="$(cat "$config")"
selected="$(echo "$tasks" | jq -j 'map(.name) | join("\n")' | \
    rofi -dmenu -matching fuzzy -i -p "Run")"
task="$(echo "$tasks" | jq ".[] | select(.name == \"$selected\")")"
[[ -z "$task" ]] && exit 1
task_command="$(echo "$task" | jq ".command")"
eval "\"$task_command\" > /dev/null &"
