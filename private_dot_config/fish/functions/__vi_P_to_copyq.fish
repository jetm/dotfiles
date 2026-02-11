function __vi_P_to_copyq --description "Vi P (paste before) from CopyQ"
    if command -q copyq
        set -l content (copyq clipboard)
        if test -n "$content"
            set -l pos (commandline -C)
            set -l line (commandline)
            set -l before (string sub -l $pos -- $line)
            set -l after (string sub -s (math $pos + 1) -- $line)
            commandline -r "$before$content$after"
            commandline -C $pos
        end
    end
end
