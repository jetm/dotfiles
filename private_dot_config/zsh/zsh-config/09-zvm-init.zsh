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
  # shellcheck disable=SC1091
  source "$ZDOTDIR"/zsh-config/key-bindings.zsh

  if [[ "$(_cached_distro_id)" == "Fedora" ]]; then
    # shellcheck disable=SC1091
    source /usr/share/fzf/shell/key-bindings.zsh
  else
    # shellcheck disable=SC1091
    source /usr/share/fzf/key-bindings.zsh
  fi

  if [[ -f "$ZDOTDIR"/zsh-config/kitty-shell-integration.zsh ]]; then
    # shellcheck disable=SC1091
    source "$ZDOTDIR"/zsh-config/kitty-shell-integration.zsh
  fi

  if [ -f /usr/share/zsh/plugins/forgit/forgit.plugin.zsh ]; then
    export FORGIT_NO_ALIASES=1
    # shellcheck disable=SC1091
    source /usr/share/zsh/plugins/forgit/forgit.plugin.zsh
  fi

  eval "$(atuin init zsh)"
  eval "$(wtp shell-init zsh)"
}

# vim:set ft=zsh ts=2 sw=2 et:
