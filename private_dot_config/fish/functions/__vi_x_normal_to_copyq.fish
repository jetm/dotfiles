function __vi_x_normal_to_copyq --description "Vi x (delete char) + sync to CopyQ"
    set -l pos (commandline -C)
    set -l line (commandline)
    set -l char (string sub -s (math $pos + 1) -l 1 -- $line)
    commandline -f delete-char
    if command -q copyq; and test -n "$char"
        copyq copy -- "$char" >/dev/null 2>&1
    end
end
