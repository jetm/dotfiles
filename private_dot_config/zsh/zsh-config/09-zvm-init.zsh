# shellcheck disable=SC2148
#
# zsh-vi-mode
#

cb_copy() {
  copyq copy - > /dev/null
}
cb_paste() {
  copyq clipboard
}

my_zvm_vi_yank() {
  zvm_vi_yank
  echo -en "$CUTBUFFER" | cb_copy
}

my_zvm_vi_delete() {
  zvm_vi_delete
  echo -en "$CUTBUFFER" | cb_copy
}

my_zvm_vi_change() {
  zvm_vi_change
  echo -en "$CUTBUFFER" | cb_copy
}

my_zvm_vi_change_eol() {
  zvm_vi_change_eol
  echo -en "$CUTBUFFER" | cb_copy
}

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

zvm_after_lazy_keybindings() {
  zvm_define_widget my_zvm_vi_yank
  zvm_define_widget my_zvm_vi_delete
  zvm_define_widget my_zvm_vi_change
  zvm_define_widget my_zvm_vi_change_eol
  zvm_define_widget my_zvm_vi_put_after
  zvm_define_widget my_zvm_vi_put_before

  zvm_bindkey visual 'y' my_zvm_vi_yank
  zvm_bindkey visual 'd' my_zvm_vi_delete
  zvm_bindkey visual 'x' my_zvm_vi_delete
  zvm_bindkey vicmd 'C' my_zvm_vi_change_eol
  zvm_bindkey visual 'c' my_zvm_vi_change
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

  _cached_init atuin atuin init zsh
}

# vim:set ft=zsh ts=2 sw=2 et:
