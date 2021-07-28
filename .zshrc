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

### End of Zinit's installer chunk

#
# Powerlevel10k
#
# Must be run just before zinit
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
zinit ice id-as'p10k' \
  silent \
  depth=1 \
  reset-prompt \
  nocd \
  atload"!source ${HOME}/.p10k.zsh"
zinit light romkatv/powerlevel10k
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

z_ice() { zinit ice lucid silent "$@" }
zi0a() { z_ice wait'0' "$@" }
zi0b() { z_ice wait'!0' "$@" }
zi0c() { z_ice wait'!1' "$@" }
zi0d() { z_ice wait'!2' "$@" }

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit id-as'z-a-rust' light-mode for zinit-zsh/z-a-rust
zinit id-as'z-a-path-dl' light-mode for zinit-zsh/z-a-patch-dl
zinit id-as'z-a-readurl' light-mode for zinit-zsh/z-a-readurl
zinit id-as'z-a-gen-mod-node' light-mode for zinit-zsh/z-a-bin-gem-node
zinit id-as'z-a-as-monitor' light-mode for zinit-zsh/z-a-as-monitor

#
# prezto plugins
#
# Required here before prezto is loaded
load_PZT_mod() { z_ice; zinit snippet PZT::modules/$1 }

zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'id_rsa_home' 'swbuildn'
zstyle ':prezto:module:prompt' theme 'off'
load_PZT_mod helper/init.zsh
load_PZT_mod environment
load_PZT_mod editor
load_PZT_mod ssh
load_PZT_mod history


#
# completion
#
zi0b id-as'zsh-autosuggestions' \
  atload'!_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zi0a id-as'zsh-completions' \
  atload"zicompinit; zicdreplay"\
  blockf
zinit light zsh-users/zsh-completions

zi0a id-as'zsh-abbrev-alias' \
  atload"source ${HOME}/.zsh/zsh-abbr-alias.conf"
zinit light momo-lab/zsh-abbrev-alias

zi0b id-as'history-search-multi-word'
zinit light zdharma/history-search-multi-word

# use `cat -v` to define the map
zi0b id-as'zsh-history-substring-search' \
  atload"bindkey '^[[A' history-substring-search-up; \
         bindkey '^[[B' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

zi0b id-as'zsh-autopair'
zinit light hlissner/zsh-autopair

zi0c id-as'fpp' \
  from"gh" \
  as"program" \
  nocompile \
  atinit"sed -i 's/python3/python3.7/g' fpp" \
  pick"fpp"
zinit light facebook/pathpicker

zi0c id-as'navi' \
  from'gh-r' \
  as'program' \
  nocompile \
  pick'navi' \
  atload'eval "$(navi widget zsh)";'
zinit light denisidoro/navi

#
# Navigation
#
zinit ice depth=1 id-as'zsh-vi-mode' \
  atload"ZVM_VI_SURROUND_BINDKEY=s-prefix; \
         ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT"
zinit light jeffreytse/zsh-vi-mode

# Zinit pack is outdated and key-bindings doesn't work. Configuration is in
# key-bindings.zsh file
zi0c id-as'fzf' \
  from"gh-r" \
  as"program" \
  has"fd" \
  nocompile \
  bpick"*linux_amd64*"
zinit light junegunn/fzf

zi0c id-as'fzf-key-bindings'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

# zi0b id-as'fzf-tab'
# zinit light Aloxaf/fzf-tab

zi0c id-as'zoxide' \
  from"gh-r" \
  as"command" \
  mv"zoxide* -> zoxide" \
  nocompile \
  bpick"*x86_64-unknown-linux*" \
  pick"zoxide/zoxide" \
  atload"source <(zoxide init zsh)"
zinit light ajeetdsouza/zoxide

# Too slow. Seems has conflict with other plugins
# It brings back live history, even when it's disabled
# zi0a id-as'zsh-autocomplete' \
#   atinit"zstyle ':autocomplete:*' min-delay 0.4; \
#     zstyle ':autocomplete:*' min-input 2; \
#     zstyle ':autocomplete:*' fzf-completion yes; \
#     zstyle ':autocomplete:*' recent-dirs no"
# zinit light marlonrichert/zsh-autocomplete

# Disable live history. Better using history-search-multi-word and fzf
# zle -A {.,}history-incremental-search-forward
# zle -A {.,}history-incremental-search-backward

# Forgot to use it
# zi0a id-as'zsh-thefuck'
# zinit light laggardkernel/zsh-thefuck

# Forgot to use it
# zi0a id-as'zsh-you-should-use'
# zinit light MichaelAquilina/zsh-you-should-use

#
# CLI Highlight & Colors
#
zi0c id-as'fast-syntax-highlighting' \
  atinit'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay'
zinit light zdharma/fast-syntax-highlighting

zi0c id-as'zsh-ls-color'
zinit light xPMo/zsh-ls-colors

#
# Diff
#
zi0c id-as'delta' \
  from'gh-r' \
  as'command' \
  nocompile \
  bpick"$PICK" \
  pick'delta/delta' \
  mv'delta* -> delta'
zinit light dandavison/delta

#
# Cheatsheet
#
zi0c id-as'tldr' \
  from'gh-r' \
  as'program' \
  nocompile \
  bpick'*linux-x86_64-musl*' \
  mv'tldr-* -> tldr' \
  sbin'tldr*'
zinit light dbrgn/tealdeer

zi0b id-as'tldr-completion' \
  has'tldr' \
  mv'tldr* -> _tldr' \
  as'completion'
zinit snippet https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

zi0c id-as'cht.sh' \
  as'command' \
  has'rlwrap' \
  nocompile \
  pick'cht.sh' \
  atload'export CHTSH="$XDG_CONFIG_HOME"'
zinit snippet https://cht.sh/:cht.sh

zi0b id-as'cht-completion' \
  has'rlwrap' \
  mv'cht* -> _cht' \
  as'completion'
zinit snippet https://cheat.sh/:zsh

zinit id-as'hacker-laws-cli' \
  as'program' \
  nocompile \
  atclone'go build' \
  atpull'%atclone' \
  pick'hacker-laws-cli' \
  for @umutphp/hacker-laws-cli

#
# Shell scripting
#
zi0c id-as'shellharden' \
  from'gh-r' \
  as'program' \
  nocompile \
  bpick'*x86_64-linux-gnu*' \
  mv'shellharden-* -> shellharden' \
  sbin'shellharden*'
zinit light anordal/shellharden

zi0c id-as'shellcheck' \
  from'gh-r' \
  as'program' \
  nocompile \
  bpick'*linux.x86_64*' \
  mv'shellcheck-*/shellcheck -> shellcheck' \
  sbin'shellcheck'
zinit light koalaman/shellcheck

zi0c id-as'shfmt' \
  from'gh-r' \
  as'program' \
  mv'shfmt* -> shfmt'
zinit light mvdan/sh

#
# File utilities
#
zi0c id-as'dust' \
  from'gh-r' \
  as'program' \
  nocompile \
  bpick'*linux*gnu*' \
  pick'dust*/dust' \
  mv'dust* -> dust'
zinit light bootandy/dust

zi0c id-as'fd' \
  from'gh-r' \
  as'command' \
  nocompile \
  pick'fd/fd' \
  mv'fd* -> fd'
zinit light sharkdp/fd

zi0a id-as"exa" \
  from"gh-r" \
  as"program" \
  nocompile \
  pick'bin/exa' \
  mv"completions/_exa -> _exa"
zinit light ogham/exa

zi0c id-as'sd' \
  from'gh-r' \
  as'program' \
  mv'sd-* -> sd' \
  sbin'sd*'
zinit light chmln/sd

zi0c id-as'bat' \
  from'gh-r' \
  as'command' \
  nocompile \
  pick'bat/bat' \
  mv'bat* -> bat'
zinit light sharkdp/bat

zi0c id-as'duf' \
  from'gh-r' \
  nocompile \
  bpick'*linux_x86_64.tar.gz' \
  as'command'
zinit light muesli/duf

#
# jq parsing
#
zi0c id-as'jq' \
  from'gh-r'  \
  as'program'  \
  nocompile \
  bpick'*linux64' \
  mv'jq-* -> jq'
zinit load stedolan/jq

zi0c id-as'fx' \
  from'gh-r' \
  as'program' \
  mv'fx* -> fx'
zinit light antonmedv/fx

#
# Monitoring
#
zi0c id-as'htop' \
  as"program" \
  ver'3.0.5' \
  atclone"./autogen.sh && ./configure --enable-delayacct && make htop" \
  atpull"%atclone" \
  pick"htop"
zinit light htop-dev/htop

#
# Grepping
#
zi0c id-as'ripgrep' \
  from'gh-r' \
  as'program' \
  nocompile \
  atclone"mv rg/doc/rg.1 $ZPFX/man/man1" \
  mv'ripgrep* -> rg' \
  pick'rg/rg'
zinit light BurntSushi/ripgrep

zi0c id-as'ugrep' \
  as'program' \
  atclone"./build.sh --prefix=$ZPFX" \
  atpull'%atclone' \
  make'install'
zinit light Genivia/ugrep

#
# Editor
#

# Release 0.5.0
zi0c id-as'nvim' \
  ver'v0.5.0' \
  as'program' \
  make"CMAKE_INSTALL_PREFIX=$ZPFX CMAKE_BUILD_TYPE=Release install" \
  atload'export EDITOR="nvim"'
zinit light neovim/neovim

zi0c id-as'glow' \
  from'gh-r' \
  as'program' \
  nocompile \
  bpick'*linux_x86_64.tar.gz' \
  pick'glow'
zinit light charmbracelet/glow

#
# File managers
#
zi0c id-as'ranger' \
  from'gh' \
  as'program' \
  depth'1' \
  nocompile \
  pick'ranger.py' \
  atload'alias ranger=ranger.py'
zinit light ranger/ranger

zi0c id-as'nnn' \
  from'github' \
  as'program'  \
  sbin'nnn' \
  make='O_NERD=1 O_PCRE=1' \
  src'misc/quitcd/quitcd.bash_zsh'
zinit light jarun/nnn

zi0c id-as'broot' \
  from'gh-r' \
  as'program' \
  nocompile \
  pick'build/x86_64-unknown-linux-musl/broot' \
  ver'latest'
zinit light Canop/broot

#
# Build tools
#
zi0c id-as'ninja' \
  from'gh-r' \
  as'command' \
  nocompile \
  bpick'*linux*' \
  pick'ninja'
zinit light ninja-build/ninja

#
# Language servers
#
zi0c id-as'efm' \
  from'gh-r' \
  as'command' \
  nocompile \
  bpick'*linux_amd64*' \
  mv"*/efm-langserver -> ${ZPFX}/bin/efm-langserver"
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
  atinit'export FORGIT_NO_ALIASES=1'
zinit light wfxr/forgit

zi0c id-as'git-reauthor' \
  as'command' \
  nocompile \
  pick'bin/git-reauthor'
zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-reauthor

zi0c id-as'git-squash' \
  as'command' \
  nocompile \
  pick'bin/git-squash'
zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-squash

zi0c id-as'git-undo' \
  as'command' \
  nocompile \
  pick'bin/git-undo'
zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-undo

zi0c id-as'git-reset-file' \
  as'command' \
  nocompile \
  pick'bin/git-reset-file'
zinit snippet https://github.com/tj/git-extras/blob/master/bin/git-reset-file

zi0c id-as'git-interactive-rebase-tool' \
  ver'2.1.0' \
  as'command' \
  rustup cargo'!git-interactive-rebase-tool' \
  pick'bin/interactive-rebase-tool'
zinit light MitMaro/git-interactive-rebase-tool

zi0c id-as'git-lfs' \
  from'gh-r' \
  as'program' \
  has'git' \
  nocompile \
  bpick'*linux-amd64*' \
  atclone"PREFIX=$ZPFX ./install.sh; \
    rm -f ./install.sh ./*.md; \
    mv ./man/*.1 $ZPFX/share/man/man1; \
    rm -rf ./man"
zinit light git-lfs/git-lfs

#
# Parallel processing
#
zinit id-as'parallel' \
  as'program' \
  nocompile \
  atclone"ziextract --auto --move && ./configure --disable-documentation --prefix=$ZPFX" \
  atpull'%atclone' \
  make'install' \
  for https://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2

# interactive parallel ssh client
zi0c id-as'hss' \
  from'gh-r' \
  as'program' \
  mv'hss-Linux-x86_64 -> hss'
zinit light six-ddc/hss

# zi0c id-as'difftastic' \
#   cargo'!difftastic'
# zinit light wilfred/difftastic

# no good integration with zsh-autocomplete
# zi0c id-as'mcfly' \
#   from"gh-r" \
#   as"command" \
#   bpick"*x86_64-unknown-linux*" \
#   pick"mcfly" \
#   atload"export MCFLY_KEY_SCHEME=vim MCFLY_FUZZY=true; source <(mcfly init zsh)"
# zinit light cantino/mcfly

if [ ! -f /etc/arch-release ] || [ ! -f /etc/manjaro-release ]; then
  zinit pack"default" for zsh

  zinit id-as'git' \
    as'readurl|command' \
    mv"%ID% -> git.zip" \
    atclone'ziextract --move git.zip' \
    atpull'%atclone' \
    make"USE_LIBPCRE2=1 -j$[$(nproc) + 1] prefix=$ZPFX install install-doc" \
    dlink"/git/git/archive/refs/tags/v%VERSION%.zip" \
    for https://github.com/git/git/releases/

  install_asdf_plugins() {
    # # https://github.com/asdf-vm/asdf-nodejs
    # nodejs \
    # issues with nodejs binaries are not found
    # export ASDF_NPM_DEFAULT_PACKAGES_FILE="$ASDF_DATA_DIR/npm-packages"; \
    # export NODEJS_CONFIGURE_OPTIONS="prefix=/users/tiamarin/.asdf/npm-packages ";' \
    local plugins_list_to_install=( \
      # https://github.com/asdf-vm/asdf-ruby.git
      ruby \
      # https://github.com/code-lever/asdf-rust
      rust \
      # https://github.com/kennyp/asdf-golang
      golang \
      # https://github.com/Stratus3D/asdf-lua.git
      lua
    )
    local installed_plugins=$(asdf plugin list)
    for plugin in $plugins_list_to_install; do
      if [[ "$installed_plugins" != *"$plugin"* ]]; then
        command asdf plugin add $plugin
        print -P "%F{blue}Added plugin for %K{white} $plugin %k and now installing the latest version...%f"
        if [[ "$plugin" == "nodejs" ]]; then
          bash -c "$ASDF_DATA_DIR/plugins/nodejs/bin/import-release-team-keyring"
        fi
        command asdf install $plugin latest
        command asdf global $plugin latest
        command asdf reshim $plugin
        print -P "%F{green}Finished installing the lastest version with asdf %K{white} $plugin %k%f."
      fi
    done
  }

  zinit id-as"asdf" \
    atinit'export ASDF_DATA_DIR="$HOME/.asdf"; \
      export ASDF_CONFIG_FILE="$ASDF_DATA_DIR/.asdfrc";' \
    src"asdf.sh" \
    atload'install_asdf_plugins; unfunction install_asdf_plugins' \
    for @asdf-vm/asdf

  zinit id-as"cargo-completion" \
    has'cargo' \
    mv"cargo* -> _cargo" \
    as"completion" \
    for https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo

  zi0c id-as'deno' \
    as"program" \
    atclone"curl -fsSL https://deno.land/x/install/install.sh | DENO_INSTALL=$ZPFX sh" \
    atpull"%atclone"
  zinit light denoland/deno_install
fi

# zi0c id-as'zeno' \
#   depth"1" \
#   blockf
# zinit light yuki-yano/zeno.zsh

# Replaced by exa
# zinit id-as'lsd' \
#   from'gh-r' \
#   as'program' \
#   mv'lsd* -> lsd' \
#   pick'lsd/lsd' \
#   for @Peltoche/lsd

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

# extensions dotfiles
zi0d id-as'dotfiles-extensions' \
  multisrc'*.zsh'
zinit light "${HOME}/.zsh"

# vim:set ts=2 sw=2 et:
