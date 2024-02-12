#
# zsh-vi-mode
#
# zsh-vi-mode will auto execute this zvm_after_init function
zvm_after_init() {
  # Require load it here as it's
  source "${HOME}"/.zsh/00-utility.zsh

  _distro=$(lsb_release -si)
  if [ "$_distro" = "Fedora" ]; then
    source /usr/share/fzf/shell/key-bindings.zsh
  else
    source /usr/share/fzf/key-bindings.zsh
  fi
  unset _distro

  source "${HOME}"/.zsh/key-bindings.sh

  source "${HOME}"/.zsh/kitty-shell-integration.sh
}

# vim:set ts=2 sw=2 et:
