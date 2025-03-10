# use antidote for plugin management
[[ -d ${HOME}/.antidote ]] ||
  git clone --depth 1 --quiet https://github.com/mattmc3/antidote ${HOME}/.antidote

source ${HOME}/.antidote/antidote.zsh

zstyle ':antidote:bundle' use-friendly-names 'yes'

# Set the name of the static .zsh plugins file antidote will generate
zsh_plugins=${HOME}/.zsh_plugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote
fpath+=(${HOME}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source static plugins file
source $zsh_plugins
unset zsh_plugins

# Make visible the comments
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=#666B74'

# vim:ft=zsh ts=2 sw=2 et:
