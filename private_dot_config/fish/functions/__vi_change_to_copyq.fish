function __vi_change_to_copyq --description "Vi change selection + sync to CopyQ"
    set -l selection (commandline --current-selection)
    commandline -f kill-selection repaint-mode
    if command -q copyq; and test -n "$selection"
        copyq copy -- "$selection" >/dev/null 2>&1
    end
end
