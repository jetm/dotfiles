# shellcheck disable=SC2148
#
# Editor
#
if command -v nvim &> /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# vim:set ft=zsh ts=2 sw=2 et:
