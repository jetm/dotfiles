# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function load_PZT_mod() {
    zinit ice silent; zinit snippet PZT::modules/$1
}

function load_PZT_mod_async() {
    zinit ice silent; zinit ice wait"0"; zinit snippet PZT::modules/$1
}

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

# zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait"0"; zinit load zdharma/history-search-multi-word
zinit ice wait"!0"; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!0'; zinit light zsh-users/zsh-history-substring-search
zinit ice wait"!1"; zinit light zdharma/fast-syntax-highlighting

# enhancd
# -------------------------------
zinit ice as"program" src"init.sh" \
  atload"source ${HOME}/.zsh/zsh-enhancd.conf"
zinit load b4b4r07/enhancd

# zplug "MichaelAquilina/zsh-auto-notify"
zinit light hlissner/zsh-autopair

zinit ice wait lucid \
    atload"source ${HOME}/.zsh/zsh-abbr-alias.conf"
zinit light momo-lab/zsh-abbrev-alias

# zinit snippet PZT::modules/helper/init.zsh
zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'
load_PZT_mod environment
load_PZT_mod terminal
load_PZT_mod editor
load_PZT_mod directory
load_PZT_mod spectrum
load_PZT_mod history
load_PZT_mod utility
load_PZT_mod completion

# load personal configs
for config (${HOME}/.zsh/*.zsh) source ${config}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
