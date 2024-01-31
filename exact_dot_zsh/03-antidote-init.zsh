# use antidote for plugin management
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone --depth 1 --quiet https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

source ${ZDOTDIR:-~}/.antidote/antidote.zsh

zstyle ':antidote:bundle' use-friendly-names 'yes'

# Set the name of the static .zsh plugins file antidote will generate
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source static plugins file
source $zsh_plugins
unset zsh_plugins

# vim:ft=zsh ts=2 sw=2 et:
