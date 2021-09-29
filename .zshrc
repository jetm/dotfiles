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

turbo_source() {
  file="$1"
  if [[ -e "$file" ]] && [[ ! -e "$file.zwc" ]] \
     || [[ "$file" -nt "$file.zwc" ]]; then
    zcompile "$file"
  fi
  source "$file"
}

turbo_source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

#
# Powerlevel10k
#
# Must be run just after zinit
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
zinit ice id-as'p10k' \
  silent \
  depth=1
zinit light romkatv/powerlevel10k

z_ice() { zinit ice lucid silent "$@" }
zi0a() { z_ice wait'0' "$@" }
zi0b() { z_ice wait'1' "$@" }
zi0c() { z_ice wait'2' "$@" }

#
# prezto plugins
#
# zinit internal load prezto module is too slow
z_ice id-as'prezto' \
  depth=1 \
  cloneonly \
  atpull"%atclone" \
  nocompile \
  nocd
zinit light sorin-ionescu/prezto

load_prezto_mod() { turbo_source "$ZINIT[PLUGINS_DIR]/prezto/modules/$1/init.zsh"; }

# Required here before prezto is loaded
zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'
load_prezto_mod helper
load_prezto_mod environment
load_prezto_mod history
load_prezto_mod utility
# requires utility
load_prezto_mod completion

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit id-as'z-a-rust' light-mode for zinit-zsh/z-a-rust
zinit id-as'z-a-readurl' light-mode for zinit-zsh/z-a-readurl
zinit id-as'z-a-path-dl' light-mode for zinit-zsh/z-a-patch-dl
zinit id-as'z-a-gen-mod-node' light-mode for zinit-zsh/z-a-bin-gem-node
zinit id-as'zsh-defer' light-mode for romkatv/zsh-defer

if [ ! -f /etc/arch-release ] || [ ! -f /etc/manjaro-release ]; then
  zinit pack for zsh

  zinit id-as'git' \
    dlink"/git/git/archive/refs/tags/v%VERSION%.zip" \
    as'readurl|null' \
    atclone"ziextract --move --auto; \
      make prefix=$ZPFX USE_LIBPCRE2=1 INSTALL_SYMLINKS=1 \
      -j$[$(nproc) + 1] all doc install install-doc &&
      rm -vf $ZPFX/bin/git-shell;
      rm -vf $ZPFX/bin/git-cvsserver;
      rm -vf $ZPFX/bin/gitk;" \
    atpull'%atclone' \
    for https://github.com/git/git/releases/

  # look for 70-asdf.zsh configuration file
  zi0a id-as'asdf' \
    atinit'export ASDF_DATA_DIR="$HOME/.asdf"; \
      export ASDF_CONFIG_FILE="$ASDF_DATA_DIR/.asdfrc";'
  zinit light asdf-vm/asdf
  turbo_source "$ZINIT[PLUGINS_DIR]/asdf/asdf.sh"

  zi0c id-as'topgrade' \
    from'gh-r' \
    as'program' \
    bpick'*x86_64-unknown-linux-gnu*' \
    pick'topgrade'
  zinit light r-darwish/topgrade

  zi0c id-as'less' \
    ver'v593' \
    as'program' \
    atclone'make -f Makefile.aut && autoreconf --install &&
      ./configure --with-regex=gnu --with-editor=nvim' \
    atpull"%atclone" \
    make"-j$[$(nproc) + 1]" \
    pick'less'
  zinit light gwsw/less

  zi0c id-as'clangd' \
    from'gh-r' \
    as'program'  \
    bpick'clangd-linux*' \
    mv'clangd*/bin/clangd -> clangd'
	zinit light clangd/clangd

  # zinit id-as'keychain' \
  #   nocompile \
  #   dlink"/funtoo/keychain/archive/refs/tags/%VERSION%.zip" \
  #   as'readurl|null' \
  #   atclone"ziextract --move --auto; \
  #     install -m755 keychain $ZPFX/bin/" \
  #   atpull'%atclone' \
  #   for https://github.com/funtoo/keychain/releases
fi

ZVM_VI_SURROUND_BINDKEY=s-prefix
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
zi0a id-as'zsh-vi-mode' \
  depth=1
zinit light jeffreytse/zsh-vi-mode

#
# completion
#
zi0a id-as'zsh-autosuggestions'
zinit light zsh-users/zsh-autosuggestions

# Extra completion no required
# zi0a id-as'zsh-completions' \
#   atload"zicompinit; zicdreplay"\
#   blockf
# zinit light zsh-users/zsh-completions

zi0a id-as'zsh-abbrev-alias' \
  src"${HOME}/.zsh/zsh-aliases"
zinit light momo-lab/zsh-abbrev-alias

# zsh-expand is quicker than zsh-abbrev-alias, but it has issues expanding 2nd
# command position

# export ZPWR_EXPAND_TO_HISTORY=true
# zi0a id-as'zsh-expand' \
#   src"${HOME}/.zsh/zsh-aliases"
# zinit light MenkeTechnologies/zsh-expand

# Replace by fzf. Conflict with Ctrl-R
# zi0b id-as'history-search-multi-word'
# zinit light zdharma/history-search-multi-word

# use `cat -v` to define the map
zi0a id-as'zsh-history-substring-search' \
  atload"bindkey '^[[A' history-substring-search-up; \
         bindkey '^[[B' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

# Quicker doing manual initialization
zi0b id-as'zsh-autopair' \
  atinit'AUTOPAIR_INHIBIT_INIT=1;'
zinit light hlissner/zsh-autopair
turbo_source "$ZINIT[PLUGINS_DIR]/zsh-autopair/autopair.zsh"
autopair-init

# replaced by tmux-fingers
# zi0c id-as'fpp' \
#   from"gh" \
#   as"program" \
#   nocompile \
#   atinit"sed -i 's/python3/python3.7/g' fpp" \
#   pick"fpp"
# zinit light facebook/pathpicker

# zi0c id-as'navi' \
#   from'gh-r' \
#   as'program' \
#   nocompile \
#   pick'navi' \
#   atload'eval "$(navi widget zsh)";'
# zinit light denisidoro/navi

#
# Navigation
#
zi0b id-as'fzf' \
  from'gh-r' \
  as'program' \
  bpick'*linux_amd64*' \
  dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh' \
  src'key-bindings.zsh' \
  pick'fzf'
zinit light junegunn/fzf

# zi0b id-as'fzf-tab'
# zinit light Aloxaf/fzf-tab

zi0c id-as'zoxide' \
  from'gh-r' \
  as'program' \
  bpick'*x86_64*linux*' \
  mv'zoxide*/zoxide -> zoxide' \
  pick'zoxide' \
  atload'eval "$(zoxide init zsh)";'
zinit light ajeetdsouza/zoxide

# Help to remember alias
# zi0a id-as'zsh-you-should-use'
# zinit light MichaelAquilina/zsh-you-should-use

# Too slow. Seems has conflict with other plugins
# It brings back live history, even when it's disabled
# zi0a id-as'zsh-autocomplete' \
#   atinit"zstyle ':autocomplete:*' min-delay 0.4; \
#     zstyle ':autocomplete:*' min-input 2; \
#     zstyle ':autocomplete:*' fzf-completion yes; \
#     zstyle ':autocomplete:*' recent-dirs no"
# zinit light marlonrichert/zsh-autocomplete

# Disable live history. Better using fzf
# zle -A {.,}history-incremental-search-forward
# zle -A {.,}history-incremental-search-backward

# Forgot to use it
# zi0a id-as'zsh-thefuck'
# zinit light laggardkernel/zsh-thefuck

#
# CLI Highlight & Colors
#
# zsh-syntax-highlighting is quicker than fast-syntax-highlighting
# atinit'ZSH_HIGHLIGHT_HIGHLIGHTERS=();'
zi0c id-as'zsh-syntax-highlighting' \
  depth=1 \
  cloneonly \
  atpull'%atclone' \
  nocompile \
  nocd
zinit light zsh-users/zsh-syntax-highlighting

# zi0a id-as'fast-syntax-highlighting'
# zinit light zdharma/fast-syntax-highlighting

#
# Diff
#
zi0c id-as'delta' \
  from'gh-r' \
  as'program' \
  bpick"$PICK" \
  mv'delta*/delta -> delta' \
  pick'delta'
zinit light dandavison/delta

#
# Cheatsheet
#
zi0c id-as'tldr' \
  from'gh-r' \
  as'program' \
  bpick'*linux-x86_64-musl*' \
  mv'tldr-* -> tldr' \
  pick'tldr'
zinit light dbrgn/tealdeer

zi0c id-as'cht.sh' \
  as'command' \
  has'rlwrap' \
  pick'cht.sh' \
  atload"export CHTSH="$XDG_CONFIG_HOME""
zinit snippet https://cht.sh/:cht.sh

#
# Shell scripting
#
zi0c id-as'shellharden' \
  from'gh-r' \
  as'program' \
  bpick'*x86_64-linux-gnu*' \
  mv'shellharden* -> shellharden' \
  pick'shellharden'
zinit light anordal/shellharden

zi0c id-as'shellcheck' \
  from'gh-r' \
  as'program' \
  bpick'*linux.x86_64*' \
  mv'shellcheck*/shellcheck -> shellcheck' \
  pick'shellcheck'
zinit light koalaman/shellcheck

zi0c id-as'shfmt' \
  from'gh-r' \
  as'program' \
  mv'shfmt* -> shfmt'
zinit light mvdan/sh

#
# JS Node modules
#
zi0c id-as'node-modules' \
  node'bash-language-server' \
  sbin'node_modules/.bin/bash-language-server'
zinit light zdharma/null

#
# File utilities
#
zi0c id-as'dust' \
  from'gh-r' \
  as'program' \
  bpick'*linux*gnu*' \
  mv'dust*/dust -> dust' \
  pick'dust'
zinit light bootandy/dust

# shim fails for fzf
zi0b id-as'fd' \
  from'gh-r' \
  as'program' \
  mv'fd*/fd -> fd' \
  pick'fd'
zinit light sharkdp/fd

zi0a id-as'exa' \
  from'gh-r' \
  as'program' \
  mv'bin/exa -> exa' \
  pick'exa'
zinit light ogham/exa

# shim fails for sd
zi0c id-as'sd' \
  from'gh-r' \
  as'program' \
  mv'sd-* -> sd' \
  pick'sd'
zinit light chmln/sd

zi0c id-as'bat' \
  from'gh-r' \
  as'program' \
  mv'bat*/bat -> bat' \
  pick'bat'
zinit light sharkdp/bat

zi0c id-as'duf' \
  from'gh-r' \
  as'program' \
  bpick'*linux_x86_64.tar.gz'
zinit light muesli/duf

# zi0c id-as'moar' \
#   as'program' \
#   atclone'go get && go build' \
#   atpull'%atclone' \
#   pick'moar'
# zinit light walles/moar

#
# jq parsing
#
# zi0c id-as'jq' \
#   from'gh-r'  \
#   as'program'  \
#   nocompile \
#   bpick'*linux64' \
#   mv'jq-* -> jq'
# zinit light stedolan/jq
#
# zi0c id-as'fx' \
#   from'gh-r' \
#   as'program' \
#   mv'fx* -> fx'
# zinit light antonmedv/fx

#
# Monitoring
#
zi0c id-as'htop' \
  as'program' \
  ver'3.0.5' \
  atclone"./autogen.sh && ./configure --enable-delayacct" \
  atpull"%atclone" \
  make'htop' \
  pick'htop'
zinit light htop-dev/htop

# required gcc 10
#  ver'v1.0.10' \
# zi0c id-as'btop' \
#   as'program' \
#   atclone"make" \
#   make"PREFIX=$ZPFX install"
# zinit light aristocratos/btop

#
# Grepping
#
zi0c id-as'ripgrep' \
  from'gh-r' \
  as'program' \
  mv'ripgrep*/rg -> rg' \
  pick'rg'
zinit light BurntSushi/ripgrep

# zi0c id-as'ugrep' \
#   as'program' \
#   atclone"./build.sh --prefix=$ZPFX" \
#   atpull'%atclone' \
#   make'install'
# zinit light Genivia/ugrep

#
# Editor
#

# Release 0.5.0
zi0c id-as'nvim' \
  ver'v0.5.1' \
  as'program' \
  make"CMAKE_INSTALL_PREFIX=$ZPFX CMAKE_BUILD_TYPE=Release install" \
  atload'export EDITOR="nvim"'
zinit light neovim/neovim

# zi0c id-as'glow' \
#   from'gh-r' \
#   as'program' \
#   nocompile \
#   bpick'*linux_x86_64.tar.gz' \
#   pick'glow'
# zinit light charmbracelet/glow

#
# File managers
#
zi0c id-as'nnn' \
  from'gh-r' \
  as'program'  \
  bpick'nnn-static*x86_64*' \
  mv'nnn-static -> nnn' \
  pick'nnn'
zinit light jarun/nnn

# zi0c id-as'broot' \
#   from'gh-r' \
#   as'program' \
#   pick'build/x86_64-unknown-linux-musl/broot' \
#   ver'latest'
# zinit light Canop/broot

# zi0c id-as'ranger' \
#   from'gh' \
#   as'program' \
#   depth'1' \
#   pick'ranger.py' \
#   atload'alias ranger=ranger.py'
# zinit light ranger/ranger

#
# Build tools
#
zi0c id-as'ninja' \
  from'gh-r' \
  as'program' \
  bpick'*linux*' \
  pick'ninja'
zinit light ninja-build/ninja

#
# Language servers
#
zi0c id-as'efm' \
  from'gh-r' \
  as'program' \
  bpick'*linux_amd64*' \
  mv'*/efm-langserver -> efm-langserver' \
  pick"efm-langserver"
zinit light mattn/efm-langserver

zi0c id-as'lua-language-server' \
  as'program' \
  atclone"git submodule update --init --recursive; \
          ninja -C 3rd/luamake -f compile/ninja/linux.ninja; \
          ./3rd/luamake/luamake rebuild;" \
  atpull'%atclone'
zinit light sumneko/lua-language-server

#
# Git utilities
#
zi0c id-as'forgit' \
  depth=1 \
  cloneonly \
  atpull'%atclone' \
  nocompile \
  nocd
zinit light wfxr/forgit

zi0c id-as'git-fuzzy' \
  as'program' \
  pick'bin/git-fuzzy'
zinit light bigH/git-fuzzy

# Put here all rust installations
# looks the mv ice doesn't work with rustup cargo
zi0c id-as'git-interactive-rebase-tool' \
  rustup cargo'git-interactive-rebase-tool' \
  as'command' \
  pick'bin/interactive-rebase-tool'
zinit light zdharma/null

zi0c id-as'git-update' \
  as'program' \
  atclone'go get && go build && mv -v gitupdate git-update' \
  atpull'%atclone' \
  pick'git-update'
zinit light nikitavoloboev/gitupdate

zi0c id-as'git-undo' \
  as'program' \
  mv'bin/git-undo -> git-undo' \
  pick'git-undo'
zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-undo

# zi0c id-as'git-reauthor' \
#   as'program' \
#   mv'bin/git-reauthor -> git-reauthor' \
#   pick'git-reauthor'
# zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-reauthor

# zi0c id-as'git-squash' \
#   as'program' \
#   mv'bin/git-squash -> git-squash' \
#   pick'git-squash'
# zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-squash

# zi0c id-as'git-reset-file' \
#   as'program' \
#   mv'bin/git-reset-file -> git-reset-file' \
#   pick'git-reset-file'
# zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-reset-file

# zi0c id-as'git-lfs' \
#   from'gh-r' \
#   as'program' \
#   nocompile \
#   bpick'*linux-amd64*' \
#   atclone"PREFIX=$ZPFX ./install.sh; \
#     rm -f ./install.sh ./*.md; \
#     mv ./man/*.1 $ZPFX/share/man/man1; \
#     rm -rf ./man"
# zinit light git-lfs/git-lfs

#
# Parallel processing
#
zinit id-as'parallel' \
  as'readurl|command' \
  nocompile \
  atclone'ziextract --auto --move && ./configure --disable-documentation' \
  atpull'%atclone' \
  make'' \
  pick'src/parallel' \
  dlink'parallel-latest.tar.bz2' \
  for https://ftp.gnu.org/gnu/parallel/

# interactive parallel ssh client
zi0c id-as'hss' \
  from'gh-r' \
  as'program' \
  mv'hss-Linux-x86_64 -> hss'
zinit light six-ddc/hss

# zi0c id-as'difftastic' \
#   cargo'!difftastic'
# zinit light wilfred/difftastic

# zi0c id-as'zeno' \
#   depth"1" \
#   blockf
# zinit light yuki-yano/zeno.zsh

# zi0c id-as'grex' \
#   from'gh-r' \
#   as'program' \
#   bpick'*linux-musl*'
# zinit light pemistahl/grex

# zi0c id-as'hyperfine' \
#   from'gh-r' \
#   as'command' \
#   bpick"$PICK" \
#   pick'hyperfine/hyperfine' \
#   mv'hyperfine* -> hyperfine'
# zinit light sharkdp/hyperfine

# zi0c id-as'lazydoker' \
#   from'gh-r' \
#   as'program' \
#   pick'lazydocker'
# zinit light jesseduffield/lazydocker

# zi0b id-as'zui'
# zinit light zdharma/zui

# zi0c id-as'zinit-console'
# zinit light zinit-zsh/zinit-console

#
# Put most source here to improve zsh load speed
#
# extensions dotfiles
for file in ${HOME}/.zsh/*.zsh; do
  turbo_source "${file}"
done
unset file

# Soure here because doing source inside of zinit is slow
turbo_source ${HOME}/.p10k.zsh

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
turbo_source "$ZINIT[PLUGINS_DIR]/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export FORGIT_NO_ALIASES=1
turbo_source "$ZINIT[PLUGINS_DIR]/forgit/forgit.plugin.sh"

zsh-defer eval $(keychain --eval --quiet --agents ssh id_rsa id_rsa_home)

unset turbo_source
unset load_prezto_mod
unset z_ice
unset zi0a
unset zi0b
unset zi0c

# vim:set ts=2 sw=2 et:
