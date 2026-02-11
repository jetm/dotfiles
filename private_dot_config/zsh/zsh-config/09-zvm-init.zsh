# shellcheck disable=SC2148
#
# zsh-vi-mode clipboard integration
#

# --- CopyQ Availability Check ---
typeset -g _ZVM_CLIPBOARD_AVAILABLE=0

if (( $+commands[copyq] )); then
  _ZVM_CLIPBOARD_AVAILABLE=1
else
  print -P "%F{yellow}[zvm]%f CopyQ not found - clipboard sync disabled" >&2
fi

# --- Clipboard Functions ---
cb_copy() {
  (( _ZVM_CLIPBOARD_AVAILABLE )) || return 0
  copyq copy - >/dev/null
}

cb_paste() {
  (( _ZVM_CLIPBOARD_AVAILABLE )) || return 0
  copyq clipboard
}

_zvm_sync_to_clipboard() {
  (( _ZVM_CLIPBOARD_AVAILABLE )) || return 0
  print -rn -- "$CUTBUFFER" | cb_copy
}

# --- Visual Mode Wrappers ---
my_zvm_vi_yank() {
  zvm_vi_yank
  _zvm_sync_to_clipboard
}

my_zvm_vi_delete() {
  zvm_vi_delete
  _zvm_sync_to_clipboard
}

my_zvm_vi_change() {
  zvm_vi_change
  _zvm_sync_to_clipboard
}

my_zvm_vi_change_eol() {
  zvm_vi_change_eol
  _zvm_sync_to_clipboard
}

# --- Normal Mode Wrappers ---
my_zvm_vi_delete_line() {
  zle kill-whole-line
  _zvm_sync_to_clipboard
}

my_zvm_vi_yank_line() {
  zle vi-yank-whole-line
  _zvm_sync_to_clipboard
}

my_zvm_vi_kill_eol() {
  zle vi-kill-eol
  _zvm_sync_to_clipboard
}

my_zvm_vi_yank_eol() {
  zle vi-yank-eol
  _zvm_sync_to_clipboard
}

my_zvm_vi_delete_char() {
  zle vi-delete-char
  _zvm_sync_to_clipboard
}

# --- Paste Wrappers ---
my_zvm_vi_put_after() {
  CUTBUFFER=$(cb_paste)
  zvm_vi_put_after
  zvm_highlight clear # zvm_vi_put_after introduces weird highlighting for me
}

my_zvm_vi_put_before() {
  CUTBUFFER=$(cb_paste)
  zvm_vi_put_before
  zvm_highlight clear # zvm_vi_put_before introduces weird highlighting for me
}

# --- Widget Definitions ---
autoload -Uz edit-command-line
zle -N edit-command-line

function kitty_scrollback_edit_command_line() {
  local VISUAL='~/.local/share/nvim/lazy/kitty-scrollback.nvim/scripts/edit_command_line.sh'
  zle edit-command-line
  zle kill-whole-line
}
zle -N kitty_scrollback_edit_command_line

fancy-ctrl-z() {
  if [[ $#BUFFER == 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z

_fzf-ripgrep_() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"

  fzf_options=(
    --ansi
    --color "hl:-1:underline,hl+:-1:underline:reverse"
    --disabled --query "$INITIAL_QUERY"
    --bind "change:reload:sleep 0.1 && $RG_PREFIX {q} || true"
    --prompt '  ripgrep > '
    --ghost='Search content...'
    --delimiter :
    --header 'Ctrl-r ripgrep | Ctrl-f fzf | Alt-n scope '
    --preview 'bat --color=always {1} --highlight-line {2}'
    --preview-window 'nohidden,<60(nohidden,up,60%,border-bottom,+{2}+3/3,~3)'
  )

  command rm -f /tmp/rg-fzf-{r,f}
  FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" fzf "${fzf_options[@]}" \
    --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(  fzf > )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
    --bind "ctrl-r:unbind(ctrl-r)+change-prompt(  ripgrep > )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
    --bind "start:unbind(ctrl-r)" \
    --bind "alt-n:transform-nth(if [[ -z \$FZF_NTH ]]; then echo 1; elif [[ \$FZF_NTH == 1 ]]; then echo 4..; else echo ''; fi)+transform-prompt(if [[ -z \$FZF_NTH ]]; then echo '  file > '; elif [[ \$FZF_NTH == 1 ]]; then echo '  content > '; else echo '  fzf > '; fi)" \
    --bind "enter:become(${EDITOR:-vim} {1} +{2})"
}

fzf-ripgrep-widget() {
  _fzf-ripgrep_"$*" < "$TTY"
  zle redisplay
}
zle -N fzf-ripgrep-widget

exit_zsh() {
  exit
}
zle -N exit_zsh

# ls automatically after cd and git status if on a git repo
function cd() {
  auto_ls() {
    if command -v eza > /dev/null; then
      eza --all --group-directories-first --icons=always
    else
      ls -Fh --color=auto --group-directories-first
    fi
  }

  builtin cd "$@"

  if [[ -d .git ]]; then
    git status
    echo ""
    auto_ls
  else
    auto_ls
  fi
}

custom_clear_screen() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' > "$TTY"
  builtin zle .reset-prompt
  builtin zle -R
}
zle -N custom_clear_screen

# --- Keybindings ---
zvm_after_lazy_keybindings() {
  # Visual mode widgets
  zvm_define_widget my_zvm_vi_yank
  zvm_define_widget my_zvm_vi_delete
  zvm_define_widget my_zvm_vi_change
  zvm_define_widget my_zvm_vi_change_eol

  # Normal mode widgets
  zvm_define_widget my_zvm_vi_delete_line
  zvm_define_widget my_zvm_vi_yank_line
  zvm_define_widget my_zvm_vi_kill_eol
  zvm_define_widget my_zvm_vi_yank_eol
  zvm_define_widget my_zvm_vi_delete_char

  # Paste widgets
  zvm_define_widget my_zvm_vi_put_after
  zvm_define_widget my_zvm_vi_put_before

  # Visual mode bindings
  zvm_bindkey visual 'y' my_zvm_vi_yank
  zvm_bindkey visual 'd' my_zvm_vi_delete
  zvm_bindkey visual 'x' my_zvm_vi_delete
  zvm_bindkey visual 'c' my_zvm_vi_change

  # Normal mode bindings
  zvm_bindkey vicmd 'C' my_zvm_vi_change_eol
  zvm_bindkey vicmd 'dd' my_zvm_vi_delete_line
  zvm_bindkey vicmd 'yy' my_zvm_vi_yank_line
  zvm_bindkey vicmd 'D' my_zvm_vi_kill_eol
  zvm_bindkey vicmd 'Y' my_zvm_vi_yank_eol
  zvm_bindkey vicmd 'x' my_zvm_vi_delete_char

  # Paste bindings
  zvm_bindkey vicmd 'p' my_zvm_vi_put_after
  zvm_bindkey vicmd 'P' my_zvm_vi_put_before
}

# zsh-vi-mode will auto execute this zvm_after_init function
zvm_after_init() {
  # 1. FZF init (must precede atuin — fzf --zsh clobbers ^r)
  _cached_init fzf fzf --zsh

  if [[ "$(_cached_distro_id)" == "Fedora" ]]; then
    # shellcheck disable=SC1091
    source /usr/share/fzf/shell/key-bindings.zsh
  else
    # shellcheck disable=SC1091
    source /usr/share/fzf/key-bindings.zsh
  fi

  # 2. Kitty shell integration
  if [[ -f "$ZDOTDIR"/zsh-config/kitty-shell-integration.zsh ]]; then
    # shellcheck disable=SC1091
    source "$ZDOTDIR"/zsh-config/kitty-shell-integration.zsh
  fi

  # 3. Atuin init
  eval "$(atuin init zsh)"

  # 4. Misc
  bindkey -M vicmd '^e' kitty_scrollback_edit_command_line
  bindkey '^Z' fancy-ctrl-z
  bindkey '^F' fzf-ripgrep-widget
  bindkey '^D' exit_zsh
  bindkey -r '^P'
  bindkey -r '^T'
  bindkey -M vicmd '^p' fzf-file-widget
  bindkey -M viins '^p' fzf-file-widget
  bindkey '^P' fzf-file-widget
  bindkey '^n' custom_clear_screen

  # 5. atuin reclaims ^r from fzf)
  bindkey -M emacs '^r' atuin-search
  bindkey -M viins '^r' atuin-search-viins
  bindkey -M vicmd '/' atuin-search
  bindkey -M viins '^t' fzf-history-widget
  bindkey -M viins '^[[A' atuin-up-search-viins
  bindkey -M vicmd '^[[A' atuin-up-search
  bindkey -M vicmd 'k' atuin-up-search

  # 6. WTP init
  _cached_init wtp wtp shell-init zsh
}

# vim:set ft=zsh ts=2 sw=2 et:
