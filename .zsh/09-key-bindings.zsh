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

export FZF_CTRL_T_COMMAND="fd --type f --hidden --exclude '.git'"
FZF_DEFAULT_OPTS+='--layout=reverse '
FZF_DEFAULT_OPTS+='--info=inline '
FZF_DEFAULT_OPTS+='--height=30% '
FZF_DEFAULT_OPTS+='--multi '
FZF_DEFAULT_OPTS+='--preview-window=:hidden '
FZF_DEFAULT_OPTS+='--preview="[ -f {} ] && cat {} || ([[ -d {}  ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200" '
FZF_DEFAULT_OPTS+='--prompt="∼ " '
FZF_DEFAULT_OPTS+='--pointer="▶" '
FZF_DEFAULT_OPTS+='--marker="✓" '
FZF_DEFAULT_OPTS+='--bind "?:toggle-preview" '
FZF_DEFAULT_OPTS+='--bind "ctrl-a:select-all" '
FZF_DEFAULT_OPTS+='--bind "ctrl-d:deselect-all" '
FZF_DEFAULT_OPTS+='--bind "ctrl-t:toggle-all" '
FZF_DEFAULT_OPTS+='--bind "ctrl-r:reload($FZF_DEFAULT_COMMAND)" '
FZF_DEFAULT_OPTS+='--bind "ctrl-y:execute-silent(echo {+} | xargs -n1 tmux set-buffer)" '
# Calling edito it fails
# FZF_DEFAULT_OPTS+='--bind "ctrl-e:execute($EDITOR {})" '
FZF_DEFAULT_OPTS+='--bind "ctrl-j:preview-page-down" '
FZF_DEFAULT_OPTS+='--bind "ctrl-k:preview-page-up" '

export FZF_DEFAULT_OPTS
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_COMPLETION_TRIGGER="@@"

# export FZF_CTRL_T_OPTS="--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1 --preview-window down:40%:noborder --preview 'xargs bat --line-range :150 --style=changes,numbers,snip --wrap=never 2> /dev/null'"

export FZF_CTRL_R_OPTS='--ansi --exact --exit-0 --inline-info --layout=default --multi --no-height --select-1'

# export FZF_ALT_C_COMMAND='fd --exclude '.git' --hidden --no-ignore-vcs --type d'
# export FZF_ALT_C_OPTS="--exact --exit-0 --inline-info --layout=default --multi --no-height --select-1 --preview-window=down:40%:noborder --preview 'exa --color=always --color-scale --group --git --icons --long --tree {} | head -150'"

#
# Skim
#
# copied and modified from https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

# The code at the top and the bottom of this file is the same as in completion.zsh.
# Refer to that file for explanation.
# if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
#   __skim_key_bindings_options="options=(${(j: :)${(kv)options[@]}})"
# else
#   () {
#     __skim_key_bindings_options="setopt"
#     'local' '__skim_opt'
#     for __skim_opt in "${(@)${(@f)$(set -o)}%% *}"; do
#       if [[ -o "$__skim_opt" ]]; then
#         __skim_key_bindings_options+=" -o $__skim_opt"
#       else
#         __skim_key_bindings_options+=" +o $__skim_opt"
#       fi
#     done
#   }
# fi
#
# 'emulate' 'zsh' '-o' 'no_aliases'
#
# {
#
# [[ -o interactive ]] || return 0

# CTRL-T - Paste the selected file path(s) into the command line
# __fsel() {
#   local cmd="git ls-tree -r --name-only HEAD || fd --type f --hidden --exclude '.git'"
#   setopt localoptions pipefail no_aliases 2> /dev/null
#   REPORTTIME_=$REPORTTIME
#   unset REPORTTIME
#   eval "$cmd" | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} --reverse $SKIM_DEFAULT_OPTIONS $SKIM_CTRL_T_OPTS" $(__skimcmd) -m "$@" | while read item; do
#     echo -n "${(q)item} "
#   done
#   local ret=$?
#   echo
#   REPORTTIME=$REPORTTIME_
#   unset REPORTTIME_
#   return $ret
# }
#
# __skimcmd() {
#   [ -n "$TMUX_PANE" ] && { [ "${SKIM_TMUX:-0}" != 0 ] || [ -n "$SKIM_TMUX_OPTS" ]; } &&
#     echo "sk-tmux ${SKIM_TMUX_OPTS:--d${SKIM_TMUX_HEIGHT:-40%}} -- " || echo "sk"
# }
#
# skim-file-widget() {
#   LBUFFER="${LBUFFER}$(__fsel)"
#   local ret=$?
#   zle reset-prompt
#   return $ret
# }
# zle     -N   skim-file-widget
# bindkey '^t' skim-file-widget

# Ensure precmds are run after cd
# skim-redraw-prompt() {
#   local precmd
#   for precmd in $precmd_functions; do
#     $precmd
#   done
#   zle reset-prompt
# }
# zle -N skim-redraw-prompt

# Bind C-f to search for and insert a file with fzy
# insert-fzy-path() {
#   emulate -L zsh
#   local selected_path already_typed_path words
#   words=("${(s/ /)LBUFFER}")
#   already_typed_path="${words[-1]}"
#   fd_cmd="fd --type file --type symlink --hidden --exclude '.git'"
#   fzy_cmd="| fzy -l20 --query='${already_typed_path}'"
#   cmd="${fd_cmd} ${fzy_cmd}"
#   selected_path=$(eval "${cmd}") || { zle reset-prompt; return; }
#   if [[ "${already_typed_path}" != '' ]]; then
#     zle backward-delete-word
#   fi
#   zle -U "${(q)selected_path}"
#   zle reset-prompt
# }
# zle -N insert-fzy-path
# bindkey "^t" insert-fzy-path

# ALT-C - cd into the selected directory
# skim-cd-widget() {
#   local cmd="${SKIM_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
#     -o -type d -print 2> /dev/null | cut -b3-"}"
#   setopt localoptions pipefail no_aliases 2> /dev/null
#   REPORTTIME_=$REPORTTIME
#   unset REPORTTIME
#   local dir="$(eval "$cmd" | SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} --reverse $SKIM_DEFAULT_OPTIONS $SKIM_ALT_C_OPTS" $(__skimcmd) --no-multi)"
#   REPORTTIME=$REPORTTIME_
#   unset REPORTTIME_
#   if [[ -z "$dir" ]]; then
#     zle redisplay
#     return 0
#   fi
#   if [ -z "$BUFFER" ]; then
#     BUFFER="cd ${(q)dir}"
#     zle accept-line
#   else
#     print -sr "cd ${(q)dir}"
#     cd "$dir"
#   fi
#   local ret=$?
#   unset dir # ensure this doesn't end up appearing in prompt expansion
#   zle skim-redraw-prompt
#   return $ret
# }
# zle     -N    skim-cd-widget
# bindkey '\ec' skim-cd-widget

# CTRL-R - Paste the selected command from history into the command line
# skim-history-widget() {
#   local selected num
#   setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
#   selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
#     SKIM_DEFAULT_OPTIONS="--height ${SKIM_TMUX_HEIGHT:-40%} $SKIM_DEFAULT_OPTIONS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $SKIM_CTRL_R_OPTS --query=${(qqq)LBUFFER} --no-multi" $(__skimcmd)) )
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
#
# } always {
#   eval $__skim_key_bindings_options
#   'unset' '__skim_key_bindings_options'
# }

# vim:set ts=2 sw=2 et:
