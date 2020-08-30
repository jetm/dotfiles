#
# Global Key Bindings
#
# History features
# bindkey "^R" history-incremental-search-backward

# Ctrl+right => forward word
bindkey "^[[1;5C" forward-word

# Ctrl+left => backward word
bindkey "^[[1;5D" backward-word

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

# Use Ctrl-Z to switch back to Vim
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# View manpage while editing a command
bindkey -M vicmd 'K' run-help

# copy current line to clipboard in Vi Insert mode with Ctrl-ay
function _copy-to-clipboard {
    print -rn -- $BUFFER | xclip
    [ -n "$TMUX" ] && tmux display-message 'Line copied to clipboard!'
}
zle -N _copy-to-clipboard
bindkey -M viins "^ay" _copy-to-clipboard

# same behavior from bash for vi-mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#
# Skim
#
# copied and modified from https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

# CTRL-T - Paste the selected file path(s) into the command line
__fsel() {
  local cmd="git ls-tree -r --name-only HEAD || fd --type f --hidden --exclude '.git' || rg --files"
  export SKIM_CTRL_T_COMMAND="${cmd}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  eval "$cmd" | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} --reverse $SKIM_DEFAULT_OPTIONS $SKIM_CTRL_T_OPTS" $(__skimcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

__skim_use_tmux__() {
  [ -n "$TMUX_PANE" ] && [ "${SKIM_TMUX:-0}" != 0 ] && [ ${LINES:-40} -gt 15 ]
}

__skimcmd() {
  __skim_use_tmux__ &&
    echo "sk-tmux -d${SKIM_TMUX_HEIGHT:-40%}" || echo "sk"
}

skim-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   skim-file-widget
bindkey '^T' skim-file-widget

# Ensure precmds are run after cd
skim-redraw-prompt() {
  local precmd
  for precmd in $precmd_functions; do
    $precmd
  done
  zle reset-prompt
}
zle -N skim-redraw-prompt

# ALT-C - cd into the selected directory
skim-cd-widget() {
  local cmd="${SKIM_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} --reverse $SKIM_DEFAULT_OPTIONS $SKIM_ALT_C_OPTS" $(__skimcmd) -m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  cd "$dir"
  unset dir # ensure this doesn't end up appearing in prompt expansion
  local ret=$?
  zle skim-redraw-prompt
  return $ret
}

zle     -N    skim-cd-widget
bindkey '\ec' skim-cd-widget

# CTRL-R - Paste the selected command from history into the command line
# skim-history-widget() {
#   local selected num
#   setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
#   selected=( $(fc -rl 1 |
#     SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} $SKIM_DEFAULT_OPTIONS -n2..,.. --tiebreak=score,index $SKIM_CTRL_R_OPTS --query=${(qqq)LBUFFER} -m" $(__skimcmd)) )
#   local ret=$?
#   if [ -n "$selected" ]; then
#     num=$selected[1]
#     if [ -n "$num" ]; then
#       zle vi-fetch-history -n $num
#     fi
#   fi
#   zle reset-prompt
#   return $ret
# }

# zle     -N   skim-history-widget
# bindkey '^R' skim-history-widget

# vim:set ts=2 sw=2 et:
