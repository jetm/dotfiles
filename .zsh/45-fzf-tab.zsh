#
# fzf-tab
#
zstyle ':completion:*' format '[%d]'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
