# shellcheck disable=SC2148

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Time format using zsh time builtin
export TIMEFMT="Time: %E"

#
# less pager
#
unset LESS

# -F quit if one screen
LESS="--quit-if-one-screen"

# -g highlight only last match for searches
LESS="${LESS} --hilite-search"

# -i ignore case
LESS="${LESS} --ignore-case"

# -M
LESS="${LESS} --long-prompt"

# -R raw
LESS="${LESS} --raw-control-chars"

# # -S
# LESS="${LESS} --chop-long-lines"

# -w
LESS="${LESS} --hilite-unread"

# -X
LESS="${LESS} --no-init"

LESS="${LESS} -z-4"

# --incsearch incremental search
LESS="${LESS} --incsearch"

# --no-histdups remove duplicates from command history
LESS="${LESS} --no-histdups"

# -~ --tilde Don't display tildes after end of file
LESS="${LESS} --tilde"

export LESS="${LESS}"

#
# PAGER
#
export PAGER=less

#
# Editor
#
if command -v nvim &> /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

#
# Yocto setup
#
NPROC=$(nproc)
export SSTATE_DIR=~/repos/work/cache/sstate \
  DL_DIR=~/repos/work/cache/downloads \
  NPROC

#
# prezto settings
#
# Set before loading prezto
zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'

#
# zsh-vi-mode
#
# zsh-vi-mode will auto execute this zvm_after_init function
zvm_after_init() {
  # Require load it here as it's
  source "${HOME}"/.zsh/00-utility.zsh

  source /usr/share/fzf/key-bindings.zsh
  source "${HOME}"/.zsh/key-bindings.sh

  source "${HOME}"/.zsh/kitty-shell-integration.sh
}

# vim:set ts=2 sw=2 et:
