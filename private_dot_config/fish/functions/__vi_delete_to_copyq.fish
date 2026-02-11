function __vi_delete_to_copyq --description "Vi delete selection + sync to CopyQ"
    set -l selection (commandline --current-selection)
    commandline -f kill-selection
    if command -q copyq; and test -n "$selection"
        copyq copy -- "$selection" >/dev/null 2>&1
    end
end
