#!/usr/bin/env bash
set -euo pipefail

# Get focused window info
window_info=$(hyprctl activewindow -j)
class=$(echo "$window_info" | jq -r '.class')

# Exit if no window focused or class is empty
[[ -z "$class" || "$class" == "null" ]] && exit 0

# Exclusion list - system UI components
excluded=("waybar" "Waybar" "hyprpanel" "")

for ex in "${excluded[@]}"; do
  [[ "$class" == "$ex" ]] && exit 0
done

# Get all PIDs for windows with same class
mapfile -t pids < <(hyprctl clients -j | jq -r ".[] | select(.class == \"$class\") | .pid")

# Send SIGTERM to each unique PID
declare -A seen_pids
for pid in "${pids[@]}"; do
  [[ -z "$pid" || "$pid" == "null" ]] && continue
  [[ -n "${seen_pids[$pid]:-}" ]] && continue
  seen_pids[$pid]=1
  kill -TERM "$pid" 2>/dev/null || true
done

# Brief check and notify if still running
sleep 0.5
for pid in "${!seen_pids[@]}"; do
  if kill -0 "$pid" 2>/dev/null; then
    notify-send -u normal "Quit" "$class did not respond to quit signal"
    break
  fi
done
