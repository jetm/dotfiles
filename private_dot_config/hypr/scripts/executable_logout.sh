#!/bin/sh

HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
hyprctl --batch "${HYPRCMDS}" >> /tmp/hypr/hyprexitwithgrace.log 2>&1

sleep 1
hyprctl dispatch exit
# loginctl kill-session "$(loginctl session-status | awk 'NR==1{print $1}')"
