function fancy_ctrl_z --description "Toggle between fg and kill-whole-line"
    if test -z (commandline)
        fg 2>/dev/null
        commandline -f repaint
    else
        commandline -f kill-whole-line repaint
    end
end
