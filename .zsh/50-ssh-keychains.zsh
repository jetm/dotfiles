# if (command -v keychain >/dev/null 2>&1); then
  # --clear option make sure an intruder cannot use your existing SSH-Agents keys
  # [ -x /usr/bin/ruby ] && keychain --clear $HOME/.ssh/id_rsa

  # [ -f $HOME/.keychain/$HOSTNAME-sh ] && source $HOME/.keychain/$HOSTNAME-sh
# fi
