# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Profiling
# zmodload zsh/zprof

export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Plugins
# zplug "modules/environment", from:prezto
# zplug "modules/editor",      from:prezto
# zplug "modules/directory",   from:prezto
# zplug "modules/terminal",    from:prezto
# zplug "modules/utility",     from:prezto
zplug "modules/completion",    from:prezto
zplug "modules/ssh",         from:prezto

zplug "zsh-users/zsh-completions", lazy:true, defer:0
# zplug "marlonrichert/zsh-autocomplete", as:plugin, defer:0
zplug "zsh-users/zsh-autosuggestions", defer:1, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:1, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:2, on:"zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search", on:"zdharma/fast-syntax-highlighting"
zplug "zdharma/fast-syntax-highlighting", use:fast-highlight
zplug "b4b4r07/zsh-vimode-visual", defer:3
zplug "b4b4r07/enhancd", use:init.sh
zplug "MichaelAquilina/zsh-auto-notify"
zplug "chrissicool/zsh-256color", defer:3
zplug "hlissner/zsh-autopair", defer:3
zplug "momo-lab/zsh-abbrev-alias", \
  hook-load: "source ${ZPLUG_REPOS}/momo-lab/zsh-abbrev-alias/abbrev-alias.plugin.zsh"
zplug "romkatv/powerlevel10k", as:theme, depth:1

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Custom zsh configuration
zplug "${HOME}/.zsh", use:"*.zsh", from:local, defer:3

# Then, source plugins and add commands to $PATH
zplug load # --verbose

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
