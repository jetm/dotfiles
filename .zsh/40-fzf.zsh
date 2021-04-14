FZF_DEFAULT_OPTS+=' --layout=reverse'
FZF_DEFAULT_OPTS+=' --info=inline'
FZF_DEFAULT_OPTS+=' --height=50%'
FZF_DEFAULT_OPTS+=' --multi'
FZF_DEFAULT_OPTS+=' --preview-window=:down:80%:hidden'
FZF_DEFAULT_OPTS+=' --preview="[ -f {} ] && bat --style=grid,snip {} || [[ -d {}  ]] && tree -C {} | less"'
FZF_DEFAULT_OPTS+=' --prompt="∼ "'
FZF_DEFAULT_OPTS+=' --pointer="▶"'
FZF_DEFAULT_OPTS+=' --marker="✓"'
FZF_DEFAULT_OPTS+=' --bind "?:toggle-preview"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-a:select-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-d:deselect-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-t:toggle-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-r:reload(eval $FZF_DEFAULT_COMMAND)"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-y:execute-silent(echo {+} | xargs -n1 tmux set-buffer)"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-e:execute(nvim {} > /dev/tty)+abort"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-j:preview-page-down"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-k:preview-page-up"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-o:execute-multi(nvim -p {} > /dev/tty)"'
export FZF_DEFAULT_OPTS
export FZF_COMPLETION_TRIGGER="@@"

export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND} --type f"
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"

FORGIT_FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}"
FORGIT_FZF_DEFAULT_OPTS+=' --preview-window=:down:80%:nohidden'
export FORGIT_FZF_DEFAULT_OPTS

FORGIT_DIFF_FZF_OPTS+=' --bind="ctrl-e:execute(nvim {-1} > /dev/tty)"'
export FORGIT_DIFF_FZF_OPTS
