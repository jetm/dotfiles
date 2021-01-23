#
# Global Key Bindings
#
# Use cat > /dev/null to know the keybinding
#

# Ctrl+right => forward word
bindkey "^[[1;5C" forward-word

# Ctrl+left => backward word
bindkey "^[[1;5D" backward-word

# Call fuck command-line
bindkey '^[[1;5A' fuck-command-line

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Use Ctrl-Z to switch back to Vim
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# same behavior from bash for vi-mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
#
# # History features
# # bindkey "^R" history-incremental-search-backward# # View manpage while editing a command
#
# bindkey -M vicmd 'K' run-help
#
# # copy current line to clipboard in Vi Insert mode with Ctrl-ay
# function _copy-to-clipboard {
#     print -rn -- $BUFFER | xclip
#     [ -n "$TMUX" ] && tmux display-message 'Line copied to clipboard!'
# }
# zle -N _copy-to-clipboard
# bindkey -M viins "^ay" _copy-to-clipboard

# vim:set ts=2 sw=2 et:
