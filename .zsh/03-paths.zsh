#
# Paths
#

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

add_path $HOME/go/bin
add_path $HOME/.cabal/bin
add_path $HOME/.cargo/bin
add_path $HOME/.poetry/bin
add_path $HOME/.local/bin

NPM_PACKAGES="${HOME}/.npm-packages"
add_path $NPM_PACKAGES/bin

add_path $HOME/bin

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

if [ -d "${HOME}/go" ]; then
  export GOPATH=${HOME}/go
fi

# Remove unwanted PATHs
path=( ${path[@]:#*ActivePython-2.7*} )
path=( ${path[@]:#*Python3.4.3*} )
path=( ${path[@]:#*slickedit*} )
path=( ${path[@]:#*ntl_tools*} )
path=( ${path[@]:#/tools} )
path=( ${path[@]:#/tools/halon} )

# vim:set ts=2 sw=2 et:
