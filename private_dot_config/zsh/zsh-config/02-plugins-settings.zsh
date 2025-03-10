#
# Plugins settings
#
# zsh-vi-mode
ZVM_VI_SURROUND_BINDKEY=s-prefix
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

# fast-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# expand and alias
export ZPWR_EXPAND_BLACKLIST=(rm mv cp ln mkdir ls l type ji)
export ZPWR_EXPAND_TO_HISTORY=true

# Git
export FORGIT_NO_ALIASES=1

# vim:ft=sh ts=2 sw=2 et:
