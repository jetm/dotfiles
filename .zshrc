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

z_ice() { zinit ice lucid silent "$@" }

load_PZT_mod() { z_ice; zinit snippet PZT::modules/$1 }

zi0a() { z_ice wait'0' "$@" }

zi0b() { z_ice wait'!0' "$@" }

zi0c() { z_ice wait'!1' "$@" }

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

zi0c as"program" \
  pick"$ZPFX/bin/git-*" \
  src"etc/git-extras-completion.zsh" \
  make"PREFIX=$ZPFX"
zinit light tj/git-extras

zi0c
zinit snippet \
  'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

zi0c from"gh-r" as"command" \
  pick"fd/fd" \
  mv"fd* -> fd"
zinit light sharkdp/fd

zi0c from"gh-r" as"command" \
  pick"bat/bat" \
  mv"bat* -> bat"
zinit light sharkdp/bat

zi0c from"gh-r" as"program" \
  mv"ripgrep* -> rg" \
  pick"rg/rg"
zinit light BurntSushi/ripgrep

zi0c from"gh-r" as"program" \
  bpick"*linux_amd64*"
zinit light junegunn/fzf

zi0c from"gh-r" as"program" \
  mv"sd-* -> sd" \
  sbin"sd*"
zinit light chmln/sd

zi0c from"gh-r" as"program" \
  pick"build/x86_64-unknown-linux-musl/broot" \
  ver"latest"
zinit light Canop/broot

zi0c from"gh-r" as"program" \
  bpick="*linux*gnu*" \
  pick="dust*/dust"
zinit light bootandy/dust

zi0c from"gh-r" as"command" \
  bpick"$PICK" \
  pick"delta/delta" \
  mv"delta* -> delta"
zinit light dandavison/delta

zi0c from"gh-r" as"command" \
  bpick"$PICK" \
  pick"hyperfine/hyperfine" \
  mv"hyperfine* -> hyperfine"
zinit light sharkdp/hyperfine

zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_rsa_home' 'swbuildn'
load_PZT_mod environment
load_PZT_mod editor
load_PZT_mod ssh
load_PZT_mod history
load_PZT_mod utility
load_PZT_mod completion

# Load personal configs
for config (${HOME}/.zsh/*.zsh) source ${config}

#
# Powerlevel10k
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zinit ice depth=1 atload"!source ${HOME}/.p10k.zsh"
zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# vim:set ts=2 sw=2 et:
