# shellcheck disable=SC2148
#
# Editor
#
if command -v nvim &> /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi
