#
# Paths
#

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

add_path $HOME/bin
add_path $HOME/.npm-global/bin
add_path $HOME/.cargo/bin
add_path $HOME/.local/bin
add_path $HOME/.cabal/bin
add_path $HOME/.npm-global/bin
add_path $HOME/.poetry/bin

if [ -d "$HOME"/local/share/man ] ; then
  if test -n "$MANPATH" ; then
    MANPATH=~/local/share/man:"${MANPATH}"
  else
    MANPATH=~/local/share/man
  fi
fi
