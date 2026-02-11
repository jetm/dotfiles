function __vi_x_to_copyq --description "Vi visual x (delete selection) + sync to CopyQ"
    set -l selection (commandline --current-selection)
    commandline -f kill-selection
    if command -q copyq; and test -n "$selection"
        copyq copy -- "$selection" >/dev/null 2>&1
    end
end
