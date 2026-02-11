function __vi_dd_to_copyq --description "Vi dd (kill whole line) + sync to CopyQ"
    set -l line (commandline)
    commandline -f kill-whole-line
    if command -q copyq; and test -n "$line"
        copyq copy -- "$line" >/dev/null 2>&1
    end
end
