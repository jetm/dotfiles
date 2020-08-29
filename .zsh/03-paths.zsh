#
# Paths
#

# Ensure path arrays do not contain duplicates
# typeset -gU cdpath fpath mailpath path

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
  PATH=~/bin:"${PATH}"
fi

NODE_GLOBAL_PATH=$HOME/.npm-global/bin
if [ -d "${NODE_GLOBAL_PATH}" ]; then
  PATH="${NODE_GLOBAL_PATH}:${PATH}"
fi

RUST_GLOBAL_PATH=$HOME/.cargo/bin
if [ -d "${RUST_GLOBAL_PATH}" ]; then
  PATH="${RUST_GLOBAL_PATH}:${PATH}"
fi

LOCAL_PATH=$HOME/.local/bin
if [ -d "${LOCAL_PATH}" ]; then
  PATH="${LOCAL_PATH}:${PATH}"
fi

CABAL_PATH=$HOME/.cabal/bin
if [ -d "${CABAL_PATH}" ]; then
  PATH="${CABAL_PATH}:${PATH}"
fi

NPM_PATH=$HOME/.npm-global/bin
if [ -d "${NPM_PATH}" ]; then
  PATH="${NPM_PATH}:${PATH}"
fi

POETRY_PATH=$HOME/.poetry/bin
if [ -d "${POETRY_PATH}" ]; then
  PATH="${POETRY_PATH}:${PATH}"
fi

if [ -d "$HOME"/local/share/man ] ; then
  if test -n "$MANPATH" ; then
    MANPATH=~/local/share/man:"${MANPATH}"
  else
    MANPATH=~/local/share/man
  fi
fi
