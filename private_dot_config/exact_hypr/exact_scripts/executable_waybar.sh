#!/usr/bin/sh

CONFIG="$HOME/.config/hypr/waybar/config.jsonc"
STYLE="$HOME/.config/hypr/waybar/style.css"

trap "killall waybar" EXIT

while true; do
  waybar --bar main-bar --log-level error --config "${CONFIG}" --style "${STYLE}" &
  inotifywait -e create,modify "$CONFIG" "$STYLE"
  killall waybar
done
