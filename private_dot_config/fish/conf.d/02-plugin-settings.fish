# Plugin configuration variables
# forgit: disable built-in aliases (we define our own abbreviations)
set -gx FORGIT_NO_ALIASES 1

# done: notification settings for long-running commands
set -g __done_min_cmd_duration 10000 # notify after 10s (milliseconds)
set -g __done_notification_command 'notify-send --app-name=fish --icon=terminal --urgency=low "Done in $CMD_DURATION" "$cmd"'

# sponge: auto-remove failed commands from history
set -g sponge_delay 5
set -g sponge_purge_only_on_exit false
set -g sponge_successful_exit_codes 0
