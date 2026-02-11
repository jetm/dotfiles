function fish_clipboard_copy
    # Override for explicit clipboard register operations (Ctrl-X, Ctrl-V, "*y, "+y).
    # Regular vi-mode operations use __vi_*_to_copyq wrappers instead.
    if command -q copyq
        copyq copy - >/dev/null 2>&1
    else if type -q xclip
        xclip -selection clipboard
    else if type -q xsel
        xsel --clipboard --input
    else if type -q wl-copy
        wl-copy
    end
end
