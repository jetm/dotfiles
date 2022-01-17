# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by zi's installer
zi_home="${HOME}/.zi"

if [[ ! -f ${zi_home}/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing Initiative Plugin Manager"
  command mkdir -p "${zi_home}" && command chmod g-rwX "${zi_home}"
  command git clone https://github.com/z-shell/zi "${zi_home}/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "${zi_home}/bin/zi.zsh"

# Next two lines must be below the above two
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
### End of zi's installer chunk

turbo_source() {
  file="$1"
  if [[ -e "$file" ]] && [[ ! -e "$file.zwc" ]] \
     || [[ "$file" -nt "$file.zwc" ]]; then
    zcompile "$file"
  fi
  source "$file"
}

zi_ice() { zi ice lucid silent "$@"; }
zi0a() { zi_ice wait'0' "$@"; }
zi0b() { zi_ice wait'1' "$@"; }
zi0c() { zi_ice wait'2' "$@"; }

#
# Powerlevel10k
#
# Must be run just after zi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
zi_ice id-as'p10k' \
  depth=1
zi light romkatv/powerlevel10k

# Git status is still slower than p10k gitstatusd
# zi_ice id-as'starship' \
#   from"gh-r" \
#   as"program" \
#   atload'!eval $(starship init zsh)'
# zi light starship/starship

zi_ice id-as'zsh-autosuggestions'
zi light zsh-users/zsh-autosuggestions

#
# prezto plugins
#
# zi internal load prezto module is too slow
zi_ice id-as'prezto' \
  depth=1 \
  cloneonly \
  atpull"%atclone" \
  nocompile \
  nocd
zi light sorin-ionescu/prezto

load_prezto_mod() { turbo_source "${ZI[PLUGINS_DIR]}/prezto/modules/$1/init.zsh"; }

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
zi id-as'z-a-readurl' light-mode for z-shell/z-a-readurl
zi id-as'z-a-path-dl' light-mode for z-shell/z-a-patch-dl
zi id-as'z-a-bin-mod-node' light-mode for z-shell/z-a-bin-gem-node

zi id-as'zsh-defer' light-mode for romkatv/zsh-defer

if [ ! -f /etc/arch-release ] || [ ! -f /etc/manjaro-release ]; then
  zi pack for zsh

  zi id-as'git' \
    dlink"/git/git/archive/refs/tags/v%VERSION%.zip" \
    as'readurl|null' \
    atclone"ziextract --move --auto; \
      make prefix=$ZPFX USE_LIBPCRE2=1 INSTALL_SYMLINKS=1 \
      -j$(nproc) all doc install install-doc &&
      rm -vf $ZPFX/bin/git-shell;
      rm -vf $ZPFX/bin/git-cvsserver;
      rm -vf $ZPFX/bin/gitk;" \
    atpull'%atclone' \
    for https://github.com/git/git/tags/

  # look for 70-asdf.zsh configuration file
  zi0a id-as'asdf' \
    atinit'export ASDF_DATA_DIR="$HOME/.asdf"; \
      export ASDF_CONFIG_FILE="$ASDF_DATA_DIR/.asdfrc";'
  zi light asdf-vm/asdf
  turbo_source "${ZI[PLUGINS_DIR]}/asdf/asdf.sh"

  zi0c id-as'topgrade' \
    from'gh-r' \
    as'program' \
    bpick'*x86_64-unknown-linux-musl*' \
    pick'topgrade'
  zi light r-darwish/topgrade

  zi0c id-as'less' \
    ver'v600' \
    as'program' \
    atclone'make -f Makefile.aut && autoreconf --install &&
      ./configure --with-regex=gnu --with-editor=nvim' \
    atpull"%atclone" \
    make"-j$(nproc)" \
    pick'less'
  zi light gwsw/less

  zi0c id-as'ov' \
    from'gh-r' \
    as'program' \
    bpick'*linux_amd64*' \
    pick'ov'
  zi light noborus/ov

  zi0c id-as'clangd' \
    from'gh-r' \
    as'program'  \
    bpick'clangd-linux*' \
    mv'clangd*/bin/clangd -> clangd'
	zi light clangd/clangd

  zi id-as'git-interactive-rebase-tool' \
    as'readurl|null' \
    nocompile \
    dlink"/MitMaro/git-interactive-rebase-tool/releases/download/%VERSION%/git-interactive-rebase-tool-%VERSION%-ubuntu-16.04_amd64.deb" \
    atclone"ziextract --move --auto; \
      dpkg -x git-interactive-rebase-tool .; \
      mv -vf usr/bin/interactive-rebase-tool $ZPFX/bin;" \
    atpull'%atclone' \
    for https://github.com/MitMaro/git-interactive-rebase-tool/releases

  zi0c id-as'tmux' \
    as"program" \
    ver"3.2a" \
    atclone"./autogen.sh && ./configure && make -j$(nproc)" \
    mv"tmux -> /ws/${USER}/shell-goodies/repos/dotfiles/bin/tmux"
  zi light tmux/tmux

  # Put here all rust installations
  # looks the mv ice doesn't work with rustup cargo

  # zi id-as'keychain' \
  #   nocompile \
  #   dlink"/funtoo/keychain/archive/refs/tags/%VERSION%.zip" \
  #   as'readurl|null' \
  #   atclone"ziextract --move --auto; \
  #     install -m755 keychain $ZPFX/bin/" \
  #   atpull'%atclone' \
  #   for https://github.com/funtoo/keychain/releases
fi

#
# vi-mode
#
ZVM_VI_SURROUND_BINDKEY=s-prefix
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
zi0c id-as'zsh-vi-mode' \
  depth=1
zi light jeffreytse/zsh-vi-mode

#
# Navigation/completion
#
# use `cat -v` to define the map
zi0b id-as'zsh-history-substring-search'
zi light zsh-users/zsh-history-substring-search

zi0b id-as'fzf' \
  from'gh-r' \
  as'program' \
  bpick'*linux_amd64*' \
  dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh' \
  pick'fzf'
zi light junegunn/fzf

# zi0b id-as'fzf-tab'
# zi light Aloxaf/fzf-tab

zi0c id-as'zoxide' \
  from'gh-r' \
  as'program' \
  bpick'*x86_64*linux*' \
  mv'zoxide*/zoxide -> zoxide' \
  pick'zoxide' \
  atload'eval "$(zoxide init zsh --cmd j)";'
zi light ajeetdsouza/zoxide

# Help to remember alias
# zi0a id-as'zsh-you-should-use'
# zi light MichaelAquilina/zsh-you-should-use

# Too slow. Seems has conflict with other plugins
# It brings back live history, even when it's disabled
# zi0a id-as'zsh-autocomplete' \
#   atinit"zstyle ':autocomplete:*' min-delay 0.4; \
#     zstyle ':autocomplete:*' min-input 2; \
#     zstyle ':autocomplete:*' fzf-completion yes; \
#     zstyle ':autocomplete:*' recent-dirs no"
# zi light marlonrichert/zsh-autocomplete

# Forgot to use it
# zi0a id-as'zsh-thefuck'
# zi light laggardkernel/zsh-thefuck

# Extra completion no required
# zi0a id-as'zsh-completions' \
#   atload"zicompinit; zicdreplay"\
#   blockf
# zi light zsh-users/zsh-completions

# zi0a id-as'zsh-abbrev-alias' \
#   src"${HOME}/.zsh/zsh-aliases"
# zi light momo-lab/zsh-abbrev-alias

# zsh-expand is quicker than zsh-abbrev-alias, but it has issues expanding 2nd
# command position

# export ZPWR_EXPAND_TO_HISTORY=true
zi0b id-as'zsh-expand' \
  src"${HOME}/.zsh/zsh-aliases"
zi light MenkeTechnologies/zsh-expand

# Replace by fzf. Conflict with Ctrl-R
# zi0b id-as'history-search-multi-word'
# zi light zdharma-continuum/history-search-multi-word

# Quicker doing manual initialization
zi0b id-as'zsh-autopair' \
  atinit'AUTOPAIR_INHIBIT_INIT=1;'
zi light hlissner/zsh-autopair
turbo_source "${ZI[PLUGINS_DIR]}/zsh-autopair/autopair.zsh"
autopair-init

# replaced by tmux-fingers
# zi0c id-as'fpp' \
#   from"gh" \
#   as"program" \
#   nocompile \
#   atinit"sed -i 's/python3/python3.7/g' fpp" \
#   pick"fpp"
# zi light facebook/pathpicker

# zi0c id-as'navi' \
#   from'gh-r' \
#   as'program' \
#   nocompile \
#   pick'navi' \
#   atload'eval "$(navi widget zsh)";'
# zi light denisidoro/navi

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
zi light zsh-users/zsh-syntax-highlighting

# zi0a id-as'fast-syntax-highlighting'
# zi light zdharma-continuum/fast-syntax-highlighting

#
# Diff
#
zi0c id-as'delta' \
  from'gh-r' \
  as'program' \
  bpick"$PICK" \
  mv'delta*/delta -> delta' \
  pick'delta'
zi light dandavison/delta

#
# Cheatsheet
#
zi0c id-as'tldr' \
  from'gh-r' \
  as'program' \
  bpick'*linux-x86_64-musl*' \
  mv'tldr-* -> tldr' \
  pick'tldr'
zi light dbrgn/tealdeer

zi0c id-as'cht.sh' \
  as'command' \
  has'rlwrap' \
  pick'cht.sh' \
  atload'export CHTSH="$XDG_CONFIG_HOME"'
zi snippet https://cht.sh/:cht.sh

#
# Shell scripting
#
zi0c id-as'shellharden' \
  from'gh-r' \
  as'program' \
  bpick'*x86_64-linux-gnu*' \
  mv'shellharden* -> shellharden' \
  pick'shellharden'
zi light anordal/shellharden

zi0c id-as'shellcheck' \
  from'gh-r' \
  as'program' \
  bpick'*linux.x86_64*' \
  mv'shellcheck*/shellcheck -> shellcheck' \
  pick'shellcheck'
zi light koalaman/shellcheck

zi0c id-as'shfmt' \
  from'gh-r' \
  as'program' \
  mv'shfmt* -> shfmt'
zi light mvdan/sh

#
# JS Node modules
#
zi0c id-as'node-modules' \
  node'bash-language-server' \
  sbin'node_modules/.bin/bash-language-server'
zi light zdharma-continuum/null

#
# File utilities
#
zi0c id-as'dust' \
  from'gh-r' \
  as'program' \
  bpick'*linux*gnu*' \
  mv'dust*/dust -> dust' \
  pick'dust'
zi light bootandy/dust

# shim fails for fzf
zi0b id-as'fd' \
  from'gh-r' \
  as'program' \
  mv'fd*/fd -> fd' \
  pick'fd'
zi light sharkdp/fd

zi0a id-as'exa' \
  from'gh-r' \
  as'program' \
  mv'bin/exa -> exa' \
  pick'exa'
zi light ogham/exa

# shim fails for sd
zi0c id-as'sd' \
  from'gh-r' \
  as'program' \
  mv'sd-* -> sd' \
  pick'sd'
zi light chmln/sd

zi0c id-as'bat' \
  from'gh-r' \
  as'program' \
  mv'bat*/bat -> bat' \
  pick'bat'
zi light sharkdp/bat

zi0c id-as'duf' \
  from'gh-r' \
  as'program' \
  bpick'*linux_x86_64.tar.gz'
zi light muesli/duf

# zi0c id-as'moar' \
#   as'program' \
#   atclone'go get && go build' \
#   atpull'%atclone' \
#   pick'moar'
# zi light walles/moar

#
# jq parsing
#
# zi0c id-as'jq' \
#   from'gh-r'  \
#   as'program'  \
#   nocompile \
#   bpick'*linux64' \
#   mv'jq-* -> jq'
# zi light stedolan/jq
#
# zi0c id-as'fx' \
#   from'gh-r' \
#   as'program' \
#   mv'fx* -> fx'
# zi light antonmedv/fx

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
zi light htop-dev/htop

# required gcc 10
#  ver'v1.0.10' \
# zi0c id-as'btop' \
#   as'program' \
#   atclone"make" \
#   make"PREFIX=$ZPFX install"
# zi light aristocratos/btop

#
# Grepping
#
zi0c id-as'ripgrep' \
  from'gh-r' \
  as'program' \
  mv'ripgrep*/rg -> rg' \
  pick'rg'
zi light BurntSushi/ripgrep

# zi0c id-as'ugrep' \
#   as'program' \
#   atclone"./build.sh --prefix=$ZPFX" \
#   atpull'%atclone' \
#   make'install'
# zi light Genivia/ugrep

#
# Editor
#

#
# neovim stable releases
#
zi0c id-as'nvim' \
  ver'v0.6.1' \
  as'program' \
  make"CMAKE_INSTALL_PREFIX=$ZPFX CMAKE_BUILD_TYPE=Release install" \
  bin"$ZPFX/bin/nvim"
zi light neovim/neovim

#
# neovim-nightlies
#
# zi0c id-as'nvim' \
#   nocompile \
#   atclone"wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz; \
#     unzip -o nvim-linux64.zip; \
#     fd nvim -x rm -vrf {} \; $ZPFX; \
#     tar xvf nvim-linux64.tar.gz --strip-components=1 -C $ZPFX; \
#     rm -f nvim-linux64.zip" \
#   atpull'%atclone'
# zi light zdharma-continuum/null

# zi0c id-as'glow' \
#   from'gh-r' \
#   as'program' \
#   nocompile \
#   bpick'*linux_x86_64.tar.gz' \
#   pick'glow'
# zi light charmbracelet/glow

#
# File managers
#
zi0c id-as'nnn' \
  from'gh-r' \
  as'program'  \
  bpick'nnn-static*x86_64*' \
  mv'nnn-static -> nnn' \
  pick'nnn'
zi light jarun/nnn

# zi0c id-as'broot' \
#   from'gh-r' \
#   as'program' \
#   pick'build/x86_64-unknown-linux-musl/broot' \
#   ver'latest'
# zi light Canop/broot

# zi0c id-as'ranger' \
#   from'gh' \
#   as'program' \
#   depth'1' \
#   pick'ranger.py' \
#   atload'alias ranger=ranger.py'
# zi light ranger/ranger

#
# Build tools
#
zi0c id-as'ninja' \
  from'gh-r' \
  as'program' \
  bpick'*linux*' \
  pick'ninja'
zi light ninja-build/ninja

#
# Language servers
#
zi0c id-as'lua-language-server' \
  as'program' \
  atclone"git submodule update --init --recursive; \
          ninja -C 3rd/luamake -f compile/ninja/linux.ninja; \
          ./3rd/luamake/luamake rebuild;" \
  atpull'%atclone'
zi light sumneko/lua-language-server

# zi0c id-as'efm' \
#   from'gh-r' \
#   as'program' \
#   bpick'*linux_amd64*' \
#   mv'*/efm-langserver -> efm-langserver' \
#   pick"efm-langserver"
# zi light mattn/efm-langserver

#
# Git utilities
#
zi0c id-as'forgit' \
  depth=1 \
  cloneonly \
  atpull'%atclone' \
  nocompile \
  nocd
zi light wfxr/forgit

zi0c id-as'git-fuzzy' \
  as'program' \
  pick'bin/git-fuzzy'
zi light bigH/git-fuzzy

zi0c id-as'git-update' \
  as'program' \
  atclone'go get && go build && mv -v gitupdate git-update' \
  atpull'%atclone' \
  pick'git-update'
zi light nikitavoloboev/gitupdate

zi0c id-as'git-undo' \
  as'program' \
  pick'git-undo'
zi snippet https://raw.githubusercontent.com/tj/git-extras/master/bin/git-undo

# It needs higher Ubuntu v16.04
# zi0c id-as'askgit' \
#   from'gh-r' \
#   as'program' \
#   bpick'*linux-amd64*' \
#   pick'askgit'
# zi light askgitdev/askgit

# Use backspace \ before $ for SHELL variable
#   nocompile \
# zi0c id-as'tabnine' \
#   atclone"local VER
#     local START_URL
#     local END_URL
#     VER=\$(curl -sS https://update.tabnine.com/bundles/version); \
#     START_URL=https://update.tabnine.com/bundles/; \
#     END_URL=/x86_64-unknown-linux-musl/TabNine.zip; \
#     wget \$START_URL\$VER\$END_URL; \
#     unzip -o TabNine.zip; \
#     rm -vf TabNine.zip
#     chmod -v +x *Tab*; \
#     mv -vf *Tab* /ws/tiamarin/home-cache/local/share/nvim/site/pack/packer/start/coq_nvim/.vars/clients/t9/; \
#     unset VER; \
#     unset START_URL; \
#     unset END_URL" \
#   atpull'%atclone'
# zi light zdharma-continuum/null

# zi0c id-as'git-reauthor' \
#   as'program' \
#   mv'bin/git-reauthor -> git-reauthor' \
#   pick'git-reauthor'
# zi snippet https://github.com/tj/git-extras/blob/master/bin/git-reauthor

# zi0c id-as'git-squash' \
#   as'program' \
#   mv'bin/git-squash -> git-squash' \
#   pick'git-squash'
# zi snippet https://github.com/tj/git-extras/blob/master/bin/git-squash

# zi0c id-as'git-reset-file' \
#   as'program' \
#   mv'bin/git-reset-file -> git-reset-file' \
#   pick'git-reset-file'
# zi snippet https://github.com/tj/git-extras/blob/master/bin/git-reset-file

# zi0c id-as'git-lfs' \
#   from'gh-r' \
#   as'program' \
#   nocompile \
#   bpick'*linux-amd64*' \
#   atclone"PREFIX=$ZPFX ./install.sh; \
#     rm -f ./install.sh ./*.md; \
#     mv ./man/*.1 $ZPFX/share/man/man1; \
#     rm -rf ./man"
# zi light git-lfs/git-lfs

#
# Parallel processing
#
zi id-as'parallel' \
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
zi light six-ddc/hss

zi0c id-as'task-spooler' \
  as'program' \
  ver'cpu-only' \
  make"PREFIX=$ZPFX -j$(nproc) install"
zi light justanhduc/task-spooler

zi0c id-as'stylua' \
  from'gh-r' \
  as'program' \
  bpick'*stylua*linux*' \
  pick'stylua'
zi light JohnnyMorganz/StyLua

# zi0c id-as'difftastic' \
#   cargo'!difftastic'
# zi light wilfred/difftastic

# zi0c id-as'zeno' \
#   depth"1" \
#   blockf
# zi light yuki-yano/zeno.zsh

# zi0c id-as'grex' \
#   from'gh-r' \
#   as'program' \
#   bpick'*linux-musl*'
# zi light pemistahl/grex

# zi0c id-as'hyperfine' \
#   from'gh-r' \
#   as'command' \
#   bpick"$PICK" \
#   pick'hyperfine/hyperfine' \
#   mv'hyperfine* -> hyperfine'
# zi light sharkdp/hyperfine

# zi0c id-as'lazydoker' \
#   from'gh-r' \
#   as'program' \
#   pick'lazydocker'
# zi light jesseduffield/lazydocker

# Soure here because doing source inside of zi is slow
turbo_source "${HOME}"/.p10k.zsh

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
turbo_source "${ZI[PLUGINS_DIR]}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export FORGIT_NO_ALIASES=1
turbo_source "${ZI[PLUGINS_DIR]}/forgit/forgit.plugin.sh"

zsh-defer eval $(keychain --eval --quiet --agents ssh id_rsa id_rsa_home)

#
# Put most source here to improve zsh load speed
#
# extensions dotfiles
for file in "${HOME}"/.zsh/*.zsh; do
  turbo_source "${file}"
done
unset file

# The plugin will auto execute this zvm_after_init function
zvm_after_init() {
  # required to read fzf key-bindings, otherwise they will be overwritten by zsh-vi-mode
  turbo_source "${ZI[PLUGINS_DIR]}/fzf/key-bindings.zsh"
}

unset turbo_source
unset load_prezto_mod
unset z_ice
unset zi0a
unset zi0b
unset zi0c

# vim:set ts=2 sw=2 et:
