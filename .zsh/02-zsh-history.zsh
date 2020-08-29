#
# History Stuff
#

# Must before hstr to replace ctrl-r keybinding
# Command-line fuzzy finder

export HISTTIMEFORMAT="%H:%M > "
HISTIGNORE='&:[bf]g:ll:h:ls:clear:exit:\&:pwd:up:cd ..:'
HISTIGNORE=${HISTIGNORE}':cd ~-:cd -:cd:jobs:set -x:ls -l:top'
HISTIGNORE=${HISTIGNORE}':%1:%2:popd:top:halt:shutdown:reboot*'
export HISTIGNORE

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
export HISTFILESIZE=1000000      # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export HISTFILE=~/.zsh_history

setopt append_history           # Dont overwrite history
setopt extended_history         # Also record time and duration of commands
setopt share_history            # Share history between multiple shells
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist
setopt hist_find_no_dups        # Dont display duplicates during searches
setopt hist_ignore_dups         # Ignore consecutive duplicates
setopt hist_ignore_all_dups     # Remember only one unique copy of the command
setopt hist_reduce_blanks       # Remove superfluous blanks
setopt hist_save_no_dups        # Omit older commands in favor of newer ones
setopt hist_ignore_space        # Ignore commands that start with space
setopt histverify               # edit a recalled history line before executing
setopt INTERACTIVECOMMENTS      # Ignore lines prefixed with '#'

# HSTR configuration
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor,substring-matching,skip-favorites-comments
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
