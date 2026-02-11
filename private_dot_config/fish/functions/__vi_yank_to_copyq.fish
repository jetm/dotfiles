function __vi_yank_to_copyq --description "Vi yank + sync to CopyQ"
    set -l selection (commandline --current-selection)
    commandline -f kill-selection yank
    if command -q copyq; and test -n "$selection"
        copyq copy -- "$selection" >/dev/null 2>&1
    end
end
