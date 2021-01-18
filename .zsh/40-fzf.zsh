export FZF_CTRL_T_COMMAND="fd --type f --hidden --exclude '.git'"
FZF_DEFAULT_OPTS+='--layout=reverse '
FZF_DEFAULT_OPTS+='--info=inline '
FZF_DEFAULT_OPTS+='--height=30% '
FZF_DEFAULT_OPTS+='--multi '
FZF_DEFAULT_OPTS+='--preview-window=:hidden '
FZF_DEFAULT_OPTS+='--preview="[ -f {} ] && cat {} || ([[ -d {}  ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200" '
FZF_DEFAULT_OPTS+='--prompt="∼ " '
FZF_DEFAULT_OPTS+='--pointer="▶" '
FZF_DEFAULT_OPTS+='--marker="✓" '
FZF_DEFAULT_OPTS+='--bind "?:toggle-preview" '
FZF_DEFAULT_OPTS+='--bind "ctrl-a:select-all" '
FZF_DEFAULT_OPTS+='--bind "ctrl-d:deselect-all" '
FZF_DEFAULT_OPTS+='--bind "ctrl-t:toggle-all" '
FZF_DEFAULT_OPTS+='--bind "ctrl-r:reload($FZF_DEFAULT_COMMAND)" '
FZF_DEFAULT_OPTS+='--bind "ctrl-y:execute-silent(echo {+} | xargs -n1 tmux set-buffer)" '
# Calling edito it fails
# FZF_DEFAULT_OPTS+='--bind "ctrl-e:execute($EDITOR {})" '
FZF_DEFAULT_OPTS+='--bind "ctrl-j:preview-page-down" '
FZF_DEFAULT_OPTS+='--bind "ctrl-k:preview-page-up" '

export FZF_DEFAULT_OPTS
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_COMPLETION_TRIGGER="@@"

# export FZF_CTRL_T_OPTS="--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1 --preview-window down:40%:noborder --preview 'xargs bat --line-range :150 --style=changes,numbers,snip --wrap=never 2> /dev/null'"

export FZF_CTRL_R_OPTS='--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1'

# export FZF_ALT_C_COMMAND='fd --exclude '.git' --hidden --no-ignore-vcs --type d'
# export FZF_ALT_C_OPTS="--exact --exit-0 --inline-info --layout=default --multi --no-height --select-1 --preview-window=down:40%:noborder --preview 'exa --color=always --color-scale --group --git --icons --long --tree {} | head -150'"
