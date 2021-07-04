#
# Executes commands at the start of an interactive session.
#

if [ -z "$PS1" ] ; then
  # If not running interactively, don't do anything
  return
fi

# Customize to your needs...

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL
# stty ixany
# stty ixoff -ixon

# beeps are annoying
setopt NO_BEEP

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

export EDITOR=nvim

#
# zsh-autocomplete
#
zstyle ':autocomplete:*' min-delay 0.4  # number of seconds (float)
# 0.0: Start autocompletion immediately when you stop typing.
# 0.4: Wait 0.4 seconds for more keyboard input before showing completions.
#
zstyle ':autocomplete:*' min-input 2  # number of characters (integer)
# 0: Show completions immediately on each new command line.
# 1: Wait for at least 1 character of input.

zstyle ':autocomplete:*' fzf-completion yes
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# ⚠️ NOTE: This can NOT be changed at runtime and requires that you have
# installed Fzf's shell extensions.
