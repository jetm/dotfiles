function fish_clipboard_paste
    # Override for explicit clipboard register operations (Ctrl-V, "*p, "+p).
    # Regular vi-mode p/P use __vi_p/P_to_copyq wrappers instead.
    if command -q copyq
        copyq clipboard
    else if type -q xclip
        xclip -selection clipboard -o
    else if type -q xsel
        xsel --clipboard --output
    else if type -q wl-paste
        wl-paste
    end
end
