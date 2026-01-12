# shellcheck disable=SC2148

if type "gpg-agent" >/dev/null; then
  if [ -n "${TTY}" ]; then
    export GPG_TTY="${TTY}"
  else
    _file=$(basename "$0")
    echo "something went wrong with tty in ${_file} run this: "
    echo "    export GPG_TTY=\$(tty)"
  fi

  gpg-connect-agent updatestartuptty /bye >/dev/null
fi

#
# SSH
#
# settings for systemd ssh-agent.service
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Depends on prezto module ssh
# zstyle ':prezto:module:ssh:load' identities 'id_rsa'

# vim:set ts=2 sw=2 et:
