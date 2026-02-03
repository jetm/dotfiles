# shellcheck disable=2148
#
# Plugins settings
#
# zsh-vi-mode
# shellcheck disable=2034
ZVM_VI_SURROUND_BINDKEY=s-prefix
# shellcheck disable=2034
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

# fast-syntax-highlighting (zdharma-continuum/fast-syntax-highlighting)
# Note: FAST_HIGHLIGHT settings replace ZSH_HIGHLIGHT_* variables for advanced theming
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# expand and alias
export ZPWR_EXPAND_BLACKLIST=(rm mv cp ln mkdir ls l type ji wget units svn)
export ZPWR_EXPAND_TO_HISTORY=true

# history-substring-search (OneDark theme)
# shellcheck disable=2034
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=114,fg=235,bold'
# shellcheck disable=2034
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=168,fg=235,bold'

# Git
export FORGIT_NO_ALIASES=1

# vim:set ft=zsh ts=2 sw=2 et:
