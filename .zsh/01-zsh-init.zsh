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
stty ixany
stty ixoff -ixon

# beeps are annoying
setopt NO_BEEP

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1
