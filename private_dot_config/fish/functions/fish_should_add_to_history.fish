function fish_should_add_to_history
    # Commands to exclude from history (exact match)
    set -l skip \
        'claude "$TRAYCER_PROMPT"'

    for pattern in $skip
        string match -q -- $pattern $argv[1]
        and return 1
    end
    return 0
end
