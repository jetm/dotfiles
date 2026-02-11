function __vi_p_to_copyq --description "Vi p (paste after) from CopyQ"
    if command -q copyq
        set -l content (copyq clipboard)
        if test -n "$content"
            commandline -i $content
        end
    end
end
