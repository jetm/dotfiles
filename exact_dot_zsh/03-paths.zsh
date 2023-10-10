# shellcheck disable=2148
#
# Paths
#

# Ensure path arrays do not contain duplicates
# shellcheck disable=2034
typeset -gU cdpath fpath mailpath path

add_path "${HOME}"/go/bin
add_path "${HOME}"/.cabal/bin
add_path "${HOME}"/.cargo/bin
add_path "${HOME}"/.poetry/bin
add_path "${HOME}"/.local/bin

NPM_PACKAGES="${HOME}/.npm-packages"
add_path "${NPM_PACKAGES}"/bin

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:${NPM_PACKAGES}/share/man"

if [ -d "${HOME}/go" ]; then
  export GOPATH=${HOME}/go
fi

add_path "${ZPFX}"/bin

add_path "${HOME}"/bin

if command -v ccache &> /dev/null; then
  add_path /usr/lib/ccache/bin
fi

# vim:set ts=2 sw=2 et:
