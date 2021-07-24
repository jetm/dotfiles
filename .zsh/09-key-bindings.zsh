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

# zsh-history-substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey $key[Up] history-substring-search-up
bindkey $key[down] history-substring-search-down

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

# vim:set ts=2 sw=2 et:
