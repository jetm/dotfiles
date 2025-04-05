# shellcheck disable=2148
# Ensure path arrays do not contain duplicates
# shellcheck disable=2034
typeset -gU cdpath fpath path

add_path "${HOME}"/.local/bin

_distro=$(lsb_release -si)

if [ "$_distro" = "Debian" ] || [ "$_distro" = "Ubuntu" ]; then
  add_path /usr/lib/cargo/bin
fi

# NPM_PACKAGES="${HOME}/.npm-packages"
# add_path "${NPM_PACKAGES}"/bin

if [ -d "${HOME}/go" ]; then
  export GOPATH=${HOME}/go
fi

add_path "${HOME}"/bin

if command -v ccache &> /dev/null; then
  add_path /usr/lib/ccache/bin
fi

unset _distro
unfunction add_path
