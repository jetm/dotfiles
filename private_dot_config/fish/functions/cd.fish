function cd --wraps='builtin cd' --description "cd with auto-ls and git status"
    builtin cd $argv; or return
    if git rev-parse --is-inside-work-tree &>/dev/null
        git status
        echo
    end
    if command -q eza
        eza --all --group-directories-first --icons=always
    else
        ls -Fh --color=auto --group-directories-first
    end
end
