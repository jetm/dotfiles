#!/bin/sh

HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
hyprctl --batch "${HYPRCMDS}" >> /tmp/hypr/hyprexitwithgrace.log 2>&1

loginctl terminate-session "$(loginctl session-status | awk 'NR==1{print $1}')"
