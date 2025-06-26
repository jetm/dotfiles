# shellcheck disable=SC2148
#
# History Stuff
#

export SAVEHIST=100000
export HISTSIZE=120000 # $HISTSIZE should be at least 20% larger than $SAVEHIST
export HISTFILE="$HOME"/.zsh_history

#
# Based on prezto
#
# BANG_HIST treats the ! character specially during expansion
setopt EXTENDED_HISTORY       # writes the history file in the :start:elapsed;command format
setopt HIST_EXPIRE_DUPS_FIRST # expires a duplicate event first when trimming history
setopt HIST_FIND_NO_DUPS      # does not display a previously found event
setopt HIST_IGNORE_ALL_DUPS   # deletes an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_DUPS       # does not record an event that was just recorded again
setopt HIST_IGNORE_SPACE      # does not record an event starting with a space
setopt HIST_SAVE_NO_DUPS      # does not write a duplicate event to the history file
setopt HIST_VERIFY            # does not execute immediately upon history expansion
setopt SHARE_HISTORY          # shares history between all sessions.
# Note that SHARE_HISTORY, INC_APPEND_HISTORY, and
# INC_APPEND_HISTORY_TIME are mutually exclusive

setopt hist_reduce_blanks # Remove superfluous blanks

#
# prezto
#
zstyle ':prezto:module:history:alias' skip 'yes'

# Set before loading prezto
zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'
