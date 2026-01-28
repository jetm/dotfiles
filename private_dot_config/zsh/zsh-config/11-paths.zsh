# shellcheck disable=2148
# Ensure path arrays do not contain duplicates
# shellcheck disable=2034
typeset -gU cdpath fpath path

add_path "${HOME}"/.local/bin
add_path "${HOME}"/.local/share/cargo/bin

if [[ "$(_cached_distro_id)" == "Debian" ]] || [[ "$(_cached_distro_id)" == "Ubuntu" ]]; then
  add_path /usr/lib/cargo/bin
fi

# NPM_PACKAGES="${HOME}/.npm-packages"
# add_path "${NPM_PACKAGES}"/bin

if [ -d "${HOME}/go" ]; then
  export GOPATH=${HOME}/go
  add_path "${HOME}"/go/bin
fi

# last to have as preference over other paths
add_path "${HOME}"/bin

if command -v ccache &> /dev/null; then
  add_path /usr/lib/ccache/bin
fi

unfunction add_path

# vim:set ft=zsh ts=2 sw=2 et:
