# Set up fzf key bindings and fuzzy completion
export FZF_ALT_C_COMMAND="fd --type=d --color=never --hidden --exclude .git --ignore"
export FZF_CTRL_T_COMMAND="fd --hidden --color=never --exclude .git --exclude .repo --ignore"

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --style=minimal"

#
# forgit
#
export FORGIT_FZF_DEFAULT_OPTS="${FORGIT_FZF_DEFAULT_OPTS} --ansi --tabstop=2 --layout=reverse --style=minimal"

# Show proper colors and not %F{yellow}
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'

eval "$(fzf --zsh)"

# vim:ft=sh ts=2 sw=2 et:
