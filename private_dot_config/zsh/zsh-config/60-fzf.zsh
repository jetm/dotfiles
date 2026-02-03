# shellcheck disable=2148
#
# Set up fzf key bindings and fuzzy completion
export FZF_ALT_C_COMMAND="fd --type=d --color=never --hidden --exclude .git --ignore"
export FZF_CTRL_T_COMMAND="fd --hidden --color=never --exclude .git --exclude .repo --ignore"

# OneDark color theme
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}
  --style=minimal
  --highlight-line
  --color=dark
  --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
  --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
  --color=border:#3e4452,nomatch:#5c6370,nth:italic
  --ghost='Search...'"

# fzf-history-widget (Ctrl+R)
export FZF_CTRL_R_OPTS="
  --ghost='Search history...'"

# fzf-file-widget (Ctrl+P)
export FZF_CTRL_T_OPTS="--ghost='Search files...'"

# fzf-cd-widget (Alt+C)
export FZF_ALT_C_OPTS="--ghost='Search directories...'"

#
# forgit
#
export FORGIT_FZF_DEFAULT_OPTS="${FORGIT_FZF_DEFAULT_OPTS} --ansi --tabstop=2 --layout=reverse --style=minimal"

# NOTE: fzf init and all bindkeys moved to 09-zvm-init.zsh (inside zvm_after_init)
# to prevent zsh-vi-mode from overriding custom keybindings.

# vim:ft=zsh ts=2 sw=2 et:
