# shellcheck disable=SC2148
FZF_DEFAULT_OPTS+=' --layout=reverse'
FZF_DEFAULT_OPTS+=' --info=inline'
FZF_DEFAULT_OPTS+=' --height=50%'
FZF_DEFAULT_OPTS+=' --multi'
FZF_DEFAULT_OPTS+=' --extended'
FZF_DEFAULT_OPTS+=' --preview-window=:down:80%:hidden'
FZF_DEFAULT_OPTS+=' --preview="[ -f {} ] && bat --style=grid,snip {} || [[ -d {}  ]] && tree -C {} | less"'
FZF_DEFAULT_OPTS+=' --prompt="∼ "'
FZF_DEFAULT_OPTS+=' --pointer="▶"'
FZF_DEFAULT_OPTS+=' --marker="✓"'
FZF_DEFAULT_OPTS+=' --bind "?:toggle-preview"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-a:select-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-d:deselect-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-t:toggle-all"'
FZF_DEFAULT_OPTS+=' --bind "ctrl-e:become(nvim {} > /dev/tty)+abort"'
# shellcheck disable=SC2089
FZF_DEFAULT_OPTS+=' --bind "ctrl-o:execute-multi(nvim -p {} > /dev/tty)"'

# shellcheck disable=SC2090
export FZF_DEFAULT_OPTS

export FZF_COMPLETION_TRIGGER="@@"

export FZF_DEFAULT_COMMAND='fd --hidden --color never --strip-cwd-prefix'
export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND} --exclude .git --exclude .repo/"
export FZF_DEFAULT_COMMAND="${FZF_DEFAULT_COMMAND} --exclude build/"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND} --type f"
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND} --type d"

# Show proper colors and not %F{yellow}
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'

#
# forgit
#
FORGIT_FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}"
FORGIT_FZF_DEFAULT_OPTS+=' --preview-window=:down:80%:nohidden'
export FORGIT_FZF_DEFAULT_OPTS

# FORGIT_DIFF_FZF_OPTS+=' --bind="ctrl-e:become(nvim {-1} > /dev/tty)"'
# export FORGIT_DIFF_FZF_OPTS

bindkey '^ ' autosuggest-accept
_zsh_autosuggest_strategy_atuin_top() {
  suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
}
ZSH_AUTOSUGGEST_STRATEGY=atuin_top

atuin-setup() {
  fzf-atuin-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
    selected=( $(atuin history list --cmd-only | tac | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |  FZF_DEFAULT_OPTS="--ansi --height ${FZF_TMUX_HEIGHT:-40%} ${FZF_DEFAULT_OPTS-} --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m" fzf) )
    local ret=$?
    if [ -n "$selected" ]; then
      cmd=$selected[1,-1]
      if [ -n "$cmd" ]; then
        zle vi-fetch-history -n $cmd
      fi
    fi
    zle -U "$cmd"
    zle kill-buffer
    zle reset-prompt
    return $ret
  }

  if ! command -v atuin > /dev/null; then
    zle      -N     fzf-history-widget
    bindkey '^R'    fzf-history-widget
  else
    zle      -N     fzf-atuin-history-widget
    bindkey '^R'    fzf-atuin-history-widget
  fi
}

# atuin-setup() {
#   export ATUIN_NOBIND="true"
#   eval "$(atuin init zsh --disable-up-arrow --disable-ctrl-r)"
#   fzf-atuin-history-widget() {
#     local selected num
#     setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
#     local atuin_opts="--cmd-only"
#     local fzf_opts=(
#       --height=${FZF_TMUX_HEIGHT:-80%}
#       --tac
#       "-n2..,.."
#       --tiebreak=index
#       "--query=${LBUFFER}"
#       "+m"
#       "--bind=ctrl-d:reload(atuin search $atuin_opts -c $PWD),ctrl-r:reload(atuin search $atuin_opts)"
#     )
#
#     selected=$(
#       eval "atuin search ${atuin_opts}" | fzf "${fzf_opts[@]}"
#     )
#     local ret=$?
#     if [ -n "$selected" ]; then
#       # Compare the current buffer and the selected command
#       # to find the missing part and add it to the buffer
#       missing_part=$(comm -13 <(echo "$LBUFFER" | sort) <(echo "$selected" | sort))
#       LBUFFER+="${missing_part}"
#     fi
#     zle reset-prompt
#     return $ret
#   }
#
#   if command -v atuin > /dev/null; then
#     zle -N fzf-atuin-history-widget
#     bindkey '^R' fzf-atuin-history-widget
#     bindkey '^E' _atuin_search_widget
#   else
#     zle -N fzf-history-widget
#     bindkey '^R' fzf-history-widget
#   fi
# }

atuin-setup

# vim:ft=sh ts=2 sw=2 et:
