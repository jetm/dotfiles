function __vi_Y_to_copyq --description "Vi Y (yank to end of line) + sync to CopyQ"
    set -l pos (commandline -C)
    set -l line (commandline)
    set -l rest (string sub -s (math $pos + 1) -- $line)
    commandline -f kill-line yank
    if command -q copyq; and test -n "$rest"
        copyq copy -- "$rest" >/dev/null 2>&1
    end
end
