export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

zmodload zsh/zprof

zplug "zplug/zplug"

#
# Prezto framework
#
zplug "jetm/prezto", \
  use:"init.zsh", \
  hook-build:"ln -s ${ZPLUG_HOME}/repos/jetm/prezto ~/.zprezto"

zplug "zsh-users/zsh-autosuggestions"
zplug "agkozak/zsh-z"
zplug "momo-lab/zsh-abbrev-alias"
zplug "wfxr/forgit"
zplug "MichaelAquilina/zsh-auto-notify"

# Custom zsh configuration
zplug "${HOME}/.zsh", \
  use:"*.zsh", \
  from:local

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

source ~/.zsh/skim-key-bindings
source ~/.zsh/abbr-alias
source ~/.zsh/git-extras-completion
