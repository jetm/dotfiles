#
# Executes commands at the start of an interactive session
#

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Add alias
[[ -f $HOME/.aliases ]] && source $HOME/.aliases

# 10 second wait if you do something that will delete everything
setopt RM_STAR_WAIT

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL
stty ixany
stty ixoff -ixon

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

# If a line starts with a space, don't save it
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# When using a hist thing, make a newline show the change before executing it
setopt HIST_VERIFY

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

#
# Key bindings
#
# History features
bindkey "^R" history-incremental-search-backward

# Ctrl+right => forward word
bindkey "^[[1;5C" forward-word

# Ctrl+left => backward word
bindkey "^[[1;5D" backward-word

# Bind Ctrl+Backspace to delete a previous word
bindkey '^H' backward-kill-word

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

# View manpage while editing a command
bindkey -M vicmd 'K' run-help

# copy current line to clipboard in Vi Insert mode with Ctrl-ay
function _copy-to-clipboard {
    print -rn -- $BUFFER | xclip
    [ -n "$TMUX" ] && tmux display-message 'Line copied to clipboard!'
}
zle -N _copy-to-clipboard
bindkey -M viins "^ay" _copy-to-clipboard

#
# Colors
#
# Terminals with any of the following set, support 256 colors (and are local)
local256="$COLORTERM$XTERM_VERSION$ROXTERM_ID$KONSOLE_DBUS_SESSION"

if [ -n "$local256" ] || [ -n "$SEND_256_COLORS_TO_REMOTE" ]; then

  case "$TERM" in
    'xterm') TERM=xterm-256color;;
    'screen') TERM=screen-256color;;
    'Eterm') TERM=Eterm-256color;;
  esac
  export TERM

  if [ -n "$TERMCAP" ] && [ "$TERM" = "screen-256color" ]; then
    TERMCAP=$(echo "$TERMCAP" | sed -e 's/Co#8/Co#256/g')
    export TERMCAP
  fi
fi

unset local256

#
# Editors
#

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#
# Paths
#

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set list of directories that cd searches
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs
path=(
  ${HOME}/bin
  ${HOME}/.rvm/bin
  /tools
  /usr/local/{bin,sbin}
  $path
)

add_path() {
  local new_entry="$1"
  case ":$PATH:" in
    *":${new_entry}:"*) :;; # already there
    *) PATH="${new_entry}:$PATH";; # Add new entry
  esac
}

# Set Ruby Gem bin and home path
# It might changes if RVM is used
if [ -x /usr/bin/ruby -a -x /usr/bin/gem ] ; then
  add_path $(ruby -e 'print Gem.user_dir')/bin
  export GEM_HOME=${HOME}/.gem
fi

# Set ccache path
if [ -d /usr/lib/ccache/bin ] ; then
  add_path /usr/lib/ccache/bin

  mkdir -p /dev/shm/ccache || \
    echo 1>&2 "error: /dev/shm/ccache could not be created"

  # Enable gcc + ccache + colorsgcc
  # if [ -d /usr/lib/colorgcc/bin ] ; then
    # PATH="/usr/lib/colorgcc/bin:${PATH}"
    # export CCACHE_PATH="/usr/bin"
  # fi
fi

# Export proxy exception for docker socket
if [ -S /var/run/docker.sock ]; then
  export no_proxy=${no_proxy},/var/run/docker.sock
  export NO_PROXY=${NO_PROXY},/var/run/docker.sock
fi

# Set Go settings
if [[ -r "$HOME/.gvm/scripts/gvm" ]]; then
  source "$HOME/.gvm/scripts/gvm"
elif [ -x /usr/bin/go -a -d ${HOME}/go ]; then
  export GOPATH=${HOME}/go
  add_path ${HOME}/go/bin
fi

# Command-line fuzzy finder
if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi

# Call Virtualenvwrapper
if [[ -r /usr/bin/virtualenvwrapper.sh ]]; then
  source /usr/bin/virtualenvwrapper.sh
fi

# Add pipsi BIN path
if [ -d ${HOME}/.local/bin ] ; then
  add_path ${HOME}/.local/bin
fi

# Add Coverity to PATH
if [ -d ${HOME}/coverity/cov-analysis-linux64-8.0.0/bin ] ; then
  add_path ${HOME}/coverity/cov-analysis-linux64-8.0.0/bin
fi

# Add completion for exercism
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  source ~/.config/exercism/exercism_completion.zsh
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

#
# Less
#

# Set the default Less options
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing)
# Remove -X and -F (exit if the content fits on one screen) to enable it
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

