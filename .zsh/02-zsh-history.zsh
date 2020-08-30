#
# History Stuff
#

HISTIGNORE='&:[bf]g:ll:h:ls:clear:exit:\&:pwd:up:cd ..:'
HISTIGNORE=${HISTIGNORE}':cd ~-:cd -:cd:jobs:set -x:ls -l:top'
HISTIGNORE=${HISTIGNORE}':%1:%2:popd:top:halt:shutdown:reboot*'
export HISTIGNORE

export HISTFILE=~/.zsh_history
export SAVEHIST=100000      # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)

#
# Based on prezto
#
# BANG_HIST treats the ! character specially during expansion
setopt EXTENDED_HISTORY  # writes the history file in the :start:elapsed;command format
setopt SHARE_HISTORY  # shares history between all sessions. Note that SHARE_HISTORY, INC_APPEND_HISTORY, and INC_APPEND_HISTORY_TIME are mutually exclusive
setopt HIST_EXPIRE_DUPS_FIRST  # expires a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS  # does not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS  # deletes an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS  # does not display a previously found event
setopt HIST_IGNORE_SPACE  # does not record an event starting with a space
setopt HIST_SAVE_NO_DUPS  # does not write a duplicate event to the history file
setopt HIST_VERIFY  # does not execute immediately upon history expansion

# export HISTTIMEFORMAT="%H:%M > "
# setopt append_history           # Dont overwrite history
# setopt extended_history         # Also record time and duration of commands
# setopt share_history            # Share history between multiple shells
# setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist
# setopt hist_find_no_dups        # Dont display duplicates during searches
# setopt hist_ignore_dups         # Ignore consecutive duplicates
# setopt hist_ignore_all_dups     # Remember only one unique copy of the command
# setopt hist_reduce_blanks       # Remove superfluous blanks
# setopt hist_save_no_dups        # Omit older commands in favor of newer ones
# setopt hist_ignore_space        # Ignore commands that start with space
# setopt histverify               # edit a recalled history line before executing
# setopt INTERACTIVECOMMENTS      # Ignore lines prefixed with '#'

# HSTR configuration
# export HSTR_CONFIG=hicolor       # get more colors
# Must before hstr to replace ctrl-r keybinding
# Command-line fuzzy finder
# alias hh=hstr                    # hh to be alias for hstr
# export HSTR_CONFIG=hicolor,substring-matching,skip-favorites-comments
# bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
