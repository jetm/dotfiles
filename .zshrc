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

# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY

# Save the time and how long a command ran
setopt EXTENDED_HISTORY

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

# History features
bindkey "^R" history-incremental-search-backward

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

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  ${HOME}/bin
  ${HOME}/.rvm/bin
  /tools
  /usr/local/{bin,sbin}
  $path
)

if [ -x /usr/bin/ruby -a -x /usr/bin/gem ] ; then
  PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:"${PATH}"
fi

# Set ccache path
if [ -d /usr/lib/ccache/bin ] ; then
  PATH=/usr/lib/ccache/bin:"${PATH}"

  mkdir -p /dev/shm/ccache || \
    echo 1>&2 "error: /dev/shm/ccache could not be created"
fi

# Export proxy exception for docker socket
if [ -S /var/run/docker.sock ]; then
  export no_proxy=${no_proxy},/var/run/docker.sock
  export NO_PROXY=${NO_PROXY},/var/run/docker.sock
fi

# Set Go settings
if [[ -s "$HOME/.gvm/scripts/gvm" ]]; then
  source "$HOME/.gvm/scripts/gvm"
elif [ -x /usr/bin/go -a -d ${HOME}/go ]; then
  export GOPATH=${HOME}/go
  PATH=${PATH}:${HOME}/go/bin
fi

