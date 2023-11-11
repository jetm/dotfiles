# shellcheck disable=SC2148

#
# Executes commands at the start of an interactive session
#
if [ -z "$PS1" ] ; then
  # If not running interactively, don't do anything
  return
fi

# Customize to your needs...

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

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
# Man Pages
#
if command -v nvim &> /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

NPROC=$(nproc)
export SSTATE_DIR=~/repos/work/cache/sstate \
  DL_DIR=~/repos/work/cache/downloads \
  NPROC

git_extras=/usr/share/doc/git-extras/git-extras-completion.zsh

if [ -f "${git_extras}" ]; then
  # shellcheck disable=SC1090
  source "${git_extras}"
fi

# vim:set ts=2 sw=2 et:
