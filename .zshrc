#
# Executes commands at the start of an interactive session.
#
# Author:
#   Javier Tia <javier.tia@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Add alias
[ -f $HOME/.aliases ] && source $HOME/.aliases

# 10 second wait if you do something that will delete everything
setopt RM_STAR_WAIT

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Ignore lines prefixed with '#'
setopt INTERACTIVECOMMENTS

# Ignore duplicate in history
setopt HIST_IGNORE_DUPS

# Prevent record in history entry if preceding them with at least one space
setopt HIST_IGNORE_SPACE

# Killer: share history between multiple shells
setopt SHARE_HISTORY

# Pretty Obvious. Right?
setopt HIST_REDUCE_BLANKS

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
