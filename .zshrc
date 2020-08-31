# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f ${HOME}/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "${HOME}/.zinit" && command chmod g-rwX "${HOME}/.zinit"
    command git clone https://github.com/zdharma/zinit "${HOME}/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

z_ice() {
    zinit ice lucid silent "$@"
}

load_PZT_mod() {
    z_ice
    zinit snippet PZT::modules/$1
}

zi0a() {
    z_ice wait'0' "$@"
}

zi0b() {
    z_ice wait'!0' "$@"
}

zi0c() {
    z_ice wait'!1' "$@"
}

zi0a
zinit light zdharma/history-search-multi-word

zi0b
zinit light zsh-users/zsh-autosuggestions

zi0b
zinit light zsh-users/zsh-history-substring-search

zi0b atload"source ${HOME}/.zsh/zsh-abbr-alias.conf"
zinit light momo-lab/zsh-abbrev-alias

zi0b
zinit light hlissner/zsh-autopair

zi0c
zinit light zdharma/fast-syntax-highlighting

# zinit snippet PZT::modules/helper/init.zsh
zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_rsa_home' 'swbuildn'
load_PZT_mod environment
load_PZT_mod terminal
load_PZT_mod editor
load_PZT_mod directory
load_PZT_mod spectrum
load_PZT_mod ssh
load_PZT_mod history
load_PZT_mod utility
load_PZT_mod completion

# load personal configs
for config (${HOME}/.zsh/*.zsh) source ${config}

# Powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zinit ice depth=1 atload"!source ${HOME}/.p10k.zsh"
zinit light romkatv/powerlevel10k
