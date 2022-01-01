#
# Global Key Bindings
#
# Use cat -v > /dev/null to know the keybinding
#

# Ctrl+right => forward word
bindkey "^[[1;5C" forward-word

# Ctrl+left => backward word
bindkey "^[[1;5D" backward-word

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

# Your custom widget
my_custom_widget() {
  echo 'Hello, ZSH!'
}

# The plugin will auto execute this zvm_after_lazy_keybindings function
zvm_after_lazy_keybindings() {
  # Here we define the custom widget
  zvm_define_widget my_custom_widget

  # In normal mode, press Ctrl-E to invoke this widget
  zvm_bindkey vicmd '^E' my_custom_widget
}

bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down

# vim:set ts=2 sw=2 et:
