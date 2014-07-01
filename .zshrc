if [ -z "$PS1" ] ; then
  # If not running interactively, don't do anything
  return
fi

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Uncomment to change how many often would you like to wait before auto-updates
# occur? (in days)
# export UPDATE_ZSH_DAYS=13

#
# Enable 256 color capabilities for appropriate terminals
#
# Set this variable in your local shell config if you want remote
# xterms connecting to this system, to be sent 256 colors.
# This can be done in /etc/csh.cshrc, or in an earlier profile.d script.
SEND_256_COLORS_TO_REMOTE=1

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jetm"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
[ -f $HOME/.aliases ] && source $HOME/.aliases

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
git
git-extras
vi-mode
history-substring-search
)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

source $HOME/.zshenv.custom

# colors for ls
if [[ -f ~/.dir_colors ]] ; then
  eval $(dircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
  eval $(dircolors -b /etc/DIR_COLORS)
fi

# Turn off annoying and useless flow control keys
stty -ixon

# Never beep at me
setterm -bfreq 0

# Nobody need flow control anymore. Troublesome feature.
#stty -ixon
setopt noflowcontrol

# Fix for tmux on linux.
case "$(uname -o)" in
  'GNU/Linux')
    export EVENT_NOEPOLL=1
    ;;
esac

# 10 second wait if you do something that will delete everything.
# I wish I'd had this before...
setopt RM_STAR_WAIT

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# History features
bindkey "^R" history-incremental-search-backward

# Ignore lines prefixed with '#'
setopt interactivecomments

# Ignore duplicate in history
setopt hist_ignore_dups

# Prevent record in history entry if preceding them with at least one space
setopt hist_ignore_space

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

#
# Useful Functions
#

up()           # up n is the same as cd ../..
{
  [[ $# -eq 0 ]] && cd ..
  if [[ $1 =~ ^[0-9]+$ ]] && [[ $1 -gt 0 ]]
  then
    dirs=1
    until [[ $dirs -gt $1 ]]
    do
      command="${command}../"
      dirs=$(($dirs+1))
    done
    cd $command
    command=''
  fi
}

debug()         # debug bash script
{
  local script="$1"; shift
  bash -x $(which $script) "$@"
}

tcalc()         # fancy way to calc
{
  awk "BEGIN { print $* }";
}

confirm()
{
  local answer
  echo -ne "zsh: sure you want to run '${YELLOW}$@${NC}' [yN]? "
  read -q answer
  echo
  if [[ "${answer}" =~ ^[Yy]$ ]]; then
    command "${=1}" "${=@:2}"
  else
    return 1
  fi
}

confirm_wrapper()
{
  if [ "$1" = '--root' ]; then
    local as_root='true'
    shift
  fi

  local runcommand="$1"; shift

  if [ "${as_root}" = 'true' ] && [ "${USER}" != 'root' ]; then
    runcommand="sudo ${runcommand}"
  fi
  confirm "${runcommand}" "$@"
}


has()
{
  local string="${1}"
  shift
  local element=''
  for element in "$@"; do
    if [ "${string}" = "${element}" ]; then
      return 0
    fi
  done
  return 1
}

begin_with()
{
  local string="${1}"
  shift
  local element=''
  for element in "$@"; do
    if [[ "${string}" =~ "^${element}" ]]; then
      return 0
    fi
  done
  return 1
}

