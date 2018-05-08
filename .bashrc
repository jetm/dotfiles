# ~/.bashrc: executed by bash(1) for non-login shells.

if [ -z "$PS1" ] ; then
  # If not running interactively, don't do anything
  return
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi

if [ -d $HOME/.rvm/bin ] ; then
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  [ -s "$HOME/.rvm/scripts/rvm" ] && \
    . "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

if [ -d ~/local/share/man ] ; then
  if test -n "$MANPATH" ; then
    MANPATH=~/local/share/man:"${MANPATH}"
  else
    MANPATH=~/local/share/man
  fi
fi

unset CDPATH

export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts
export PAGER="less"
export LESS="-I -j6 -M -F -X -R"

for editor in vim vi editor ; do
  if command -v $editor &> /dev/null ; then
    export EDITOR=`command -v $editor`
    break
  fi
done

# History Stuff
export HISTTIMEFORMAT="%H:%M > "
HISTIGNORE='&:[bf]g:ll:h:ls:clear:exit:\&:pwd:up:cd ..:free*:df*'
HISTIGNORE=${HISTIGNORE}':cd ~-:cd -:cd:jobs:set -x:ls -l:top'
HISTIGNORE=${HISTIGNORE}':%1:%2:popd:top:halt:shutdown:reboot*'
export HISTIGNORE
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROl=ignoreboth

history()
{
  _bash_history_sync
  builtin history "$@"
}

_bash_history_sync()
{
  builtin history -a
  HISTFILESIZE=$HISTFILESIZE
  builtin history -c
  builtin history -r
}

export PROMPT_COMMAND=_bash_history_sync

for LANG in en_US.utf8 en_US.UTF-8 en_US C ; do
  if locale -a | grep -q -x -F $LANG ; then
    export LANG
    break
  fi
done

#
# Shell opts: see bash(1)
#
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s cdable_vars        # if cd arg fail, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s histreedit         # reedit a history substitution line if it failed
shopt -s checkhash
shopt -s dirspell
shopt -s no_empty_cmd_completion
#shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
#shopt -s dotglob            # include dotfiles in pathname expansion
#shopt -s histverify         # edit a recalled history line before executing
#shopt -s nocaseglob         # pathname expansion will be treated as case-insensitive

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
  && type -P dircolors >/dev/null \
  && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if type -P dircolors >/dev/null ; then
    if [[ -f ~/.dir_colors ]] ; then
      eval $(dircolors -b ~/.dir_colors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
      eval $(dircolors -b /etc/DIR_COLORS)
    fi
  fi

  if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\]\n$ '
  else
    PS1='[\# ${clearcase_view}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " (%s)")\[\033[00m\]]\n$ '
    #PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
  fi

  alias ls='ls -hF --color=always --group-directories-first'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  if [[ ${EUID} == 0 ]] ; then
    # show root@ when we don't have colors
    # PS1='\u@\h \W \$ '
    PS1='[\# ${clearcase_view}\u@\h:\W$(__git_ps1 " (%s)")] '
  else
    #PS1='\u@\h \w \$ '
    PS1='[\# ${clearcase_view}\u@\h:\w$(__git_ps1 " (%s)")] '
  fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

if [ -n "$DISPLAY" -a "$TERM" == "xterm" -a \
  -e /usr/share/terminfo/x/xterm-256color ]; then
export TERM=xterm-256color
fi

# Turn off annoying and useless flow control keys
stty -ixon

up ()           # up n is the same as cd ../..
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

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

#
# Other Alias
#
alias ll='ls -l'
alias l.='ls -d .*'
alias pong='ping -c4 www.google.com'
alias ip="curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'"

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# aliases for git
alias g='git'
alias gnp='git --no-pager'
complete -o default -o nospace -F _git g

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
