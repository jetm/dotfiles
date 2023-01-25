# shellcheck disable=SC2148

if type "gpg-agent" >/dev/null; then
  # if it looks like it's already running, don't bother
  # starting the agent

  # p10k does strange things with `tty`, so we play it safe

  # we do have the agent, so we always want to set this in a new session
  GPG_TTY=$(tty)
  export GPG_TTY

  if [ "${GPG_TTY}" = "not a tty" ]; then
    if [ -n "${TTY}" ]; then
      export GPG_TTY="${TTY}"
    else
      _file=$(basename "$0")
      echo "something went wrong with tty in ${_file} run this: "
      echo "    export GPG_TTY=$(tty)"
    fi
  fi

  gpg-connect-agent updatestartuptty /bye >/dev/null
fi

# vim:set ts=2 sw=2 et:
