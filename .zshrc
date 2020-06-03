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
zplug "romkatv/powerlevel10k"

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

# Then, source plugins and add cjommands to $PATH
zplug load # --verbose

source ~/.zsh/skim-key-bindings
source ~/.zsh/abbr-alias
source ~/.zsh/git-extras-completion

source /users/tiamarin/.config/broot/launcher/bash/br

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
