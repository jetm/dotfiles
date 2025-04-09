# shellcheck disable=2148
#
# Plugins settings
#
# zsh-vi-mode
# shellcheck disable=2034
ZVM_VI_SURROUND_BINDKEY=s-prefix
# shellcheck disable=2034
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

# fast-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# expand and alias
export ZPWR_EXPAND_BLACKLIST=(rm mv cp ln mkdir ls l type ji wget units svn)
export ZPWR_EXPAND_TO_HISTORY=true

# Git
# export FORGIT_NO_ALIASES=1

# vim:ft=sh ts=2 sw=2 et:
