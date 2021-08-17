#
# Executes commands at the start of an interactive session
#

if [ -z "$PS1" ] ; then
  # If not running interactively, don't do anything
  return
fi

# Customize to your needs...

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

#
# PAGER
#
export PAGER="${HOME}/.zinit/plugins/moar/moar -wrap -no-linenumbers"

#
# Man Pages
#
export MANPATH="$ZPFX/share/man${MANPATH:+$MANPATH}"
