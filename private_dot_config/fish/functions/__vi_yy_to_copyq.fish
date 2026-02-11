function __vi_yy_to_copyq --description "Vi yy (yank whole line) + sync to CopyQ"
    set -l line (commandline)
    commandline -f kill-whole-line yank
    if command -q copyq; and test -n "$line"
        copyq copy -- "$line" >/dev/null 2>&1
    end
end
