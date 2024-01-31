#
# Completion
#
run_compinit() {
  # run compinit in a smarter, faster way
  emulate -L zsh
  setopt localoptions extendedglob

  autoload -Uz compinit

  # if compdump is less than 20 hours old,
  # consider it fresh and shortcut it with `compinit -C`
  #
  # Glob magic explained:
  #   #q expands globs in conditional expressions
  #   N - sets null_glob option (no error on 0 results)
  #   mh-20 - modified less than 20 hours ago
  ZSH_COMPDUMP="${HOME}/.zcompdump"
  if [[ "$1" != "-f" ]] && [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$ZSH_COMPDUMP"
  else
    compinit -i -d "$ZSH_COMPDUMP"
    touch "$ZSH_COMPDUMP"
  fi

    # Compile zcompdump, if modified, in background to increase startup speed.
  {
    local ZFILE=/tmp/zfile
    touch "${ZFILE}"
    if [[ -s "$ZSH_COMPDUMP" && \
      (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") \
      && ! -e ${ZFILE} ]]; then
      zcompile "$ZSH_COMPDUMP"
    fi
    rm -f "${ZFILE}"
  } &!
}

run_compinit
unfunction run_compinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

TRAPUSR1() { rehash }

# Not mature enough. Try again later. Disable fzf-tab to avoid conflicts
# if (command -v carapace >/dev/null 2>&1); then
#   source <(carapace _carapace)
# fi
