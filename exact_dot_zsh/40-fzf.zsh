# shellcheck disable=SC2148
export FZF_SHOW_HELP_OPTS="$(
cat <<-EOF

        FZF Keybinds Shortcut

        ?           Toggle/Hide Preview
        C-space     Change preview layout
        C-e         Open in Editor
        C-/         Directory: Navigate on broot
        C-/         File: Open in Pager (bat)

        M-s         Toggle Sort
        C-y         Copy/Yank
        C-M-y       Copy/Yank Working Directory
        Del         Delete/Remove file

        Alt-?       Help (this page)
        ESC         Quit
EOF
)"

export FZF_PREVIEW_OPTS="--preview
'([[ -f {} ]] && (bat --style=header,numbers,changes,plain --color=always --language=sh --line-range :500 {} || cat {})) ||
([[ -d {} ]] && (lsd  -all --long --tree --depth=5 --group-dirs=first -I=.git {} )) || echo {} 3>/dev/null | head -n 500'
"

export FZF_PREVIEW_KEYBIND_OPTS="
--bind '?:toggle-preview'
--bind 'alt-?:preview(printf \"${FZF_SHOW_HELP_OPTS}\")'
--bind 'alt-j:preview-down'
--bind 'alt-k:preview-up'
--bind 'ctrl-d:preview-page-down'
--bind 'ctrl-u:preview-page-up'
--bind 'ctrl-t:preview-top'
--bind 'ctrl-b:preview-bottom'
--bind 'ctrl-l:clear-screen+clear-query+first'
--bind 'ctrl-space:change-preview-window(right,80%,nohidden|down,80%,border-top,nohidden|down,50%,nohidden|up,80%,border-down,nohidden|up,50%,nohidden|left,80%,nohidden|left,50%,nohidden|down:3:nohidden:wrap|up:3,nohidden:wrap|right,50%,nohidden)'
"

export FZF_KEYBIND_SHORTCUTS="
$FZF_PREVIEW_KEYBIND_OPTS
--bind 'alt-s:toggle-sort'
--bind 'ctrl-/:execute(
if [[ -d {} ]]; then
  broot {} < /dev/tty > /dev/tty 2>&1
else
  bat --paging=always --style=plain --color=always --language=sh {} > /dev/tty
fi)'
--bind 'ctrl-y:execute-silent(printf '%s' {+} | cb copy)'
--bind 'ctrl-alt-y:execute-silent(readlink -f {+} | cb copy)'
--bind 'ctrl-e:execute([[ -f {} ]] && ${EDITOR} {+} > /dev/tty)'
--bind 'del:execute([[ -e {} ]] && rm -i {+})+reload($FZF_DEFAULT_COMMAND)+clear-screen'
"

export FZF_DEFAULT_COMMAND="fd --color=never --hidden --exclude .git --exclude .repo/ --exclude build/"

export FZF_DEFAULT_OPTS="
"$FZF_PREVIEW_OPTS"
"$FZF_KEYBIND_SHORTCUTS"
-i
--ansi
--multi
--height=90%
--info=inline
--no-separator
--layout=reverse
--preview-window=:hidden
"

export FZF_ALT_C_COMMAND="fd --type=d --color=always --hidden --exclude .git"

export FZF_ALT_C_OPTS="
--preview 'lsd --all --long --tree --depth=3 {} | head -500'
--preview-window 'nohidden,<50(down,75%,border-top)'
--bind 'alt-h:reload(fd --type=d --color=always --follow --exclude .git)'
--bind 'alt-c:reload(fd -p ~ --color=always --hidden --type=d --follow)'
"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_CTRL_T_OPTS="
--exit-0
--select-1
--info=default
--layout=reverse-list
--preview-window '50%,<50(up,75%,border-down)'
--header 'Alt-D: Directories | Alt-F: Files | Alt-H: Hide Files'
--bind 'alt-d:change-prompt(  Directories > )+reload("$FZF_ALT_C_COMMAND")'
--bind 'alt-f:change-prompt(  Files > )+reload("$FZF_DEFAULT_COMMAND")'
--bind 'alt-h:change-prompt(  Hide Files > )+reload(fd --type=f --color=always --follow)'
--bind 'ctrl-t:change-prompt(Home > )+reload(fd --base-directory ~ --color=always --hidden --exclude .git)'
"

export FZF_CTRL_R_OPTS="
--preview 'echo {+} | bat --color=always --wrap never --language=sh --style=plain'
--preview-window 'down:3:nohidden:wrap'"

_fzf_compgen_path() {
  fd --color=never --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --color=never --type d --hidden --follow --exclude ".git" . "$1"
}

# Show proper colors and not %F{yellow}
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'

#
# forgit
#
FORGIT_FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}"
FORGIT_FZF_DEFAULT_OPTS+=' --preview-window=:down:80%:nohidden'
export FORGIT_FZF_DEFAULT_OPTS

# FORGIT_DIFF_FZF_OPTS+=' --bind="ctrl-e:become(nvim {-1} > /dev/tty)"'
# export FORGIT_DIFF_FZF_OPTS

bindkey '^ ' autosuggest-accept
_zsh_autosuggest_strategy_atuin_top() {
  suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
}
ZSH_AUTOSUGGEST_STRATEGY=atuin_top

atuin-setup() {
  fzf-atuin-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
    # shellcheck disable=SC2296
    selected=( $(atuin history list --cmd-only | tac | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |  FZF_DEFAULT_OPTS="--ansi --height ${FZF_TMUX_HEIGHT:-40%} ${FZF_DEFAULT_OPTS-} --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m" fzf) )
    local ret=$?
    if [ -n "$selected" ]; then
      # shellcheck disable=SC1087
      cmd=$selected[1,-1]
      if [ -n "$cmd" ]; then
        zle vi-fetch-history -n $cmd
      fi
    fi
    zle -U "$cmd"
    zle kill-buffer
    zle reset-prompt
    return $ret
  }

  if ! command -v atuin > /dev/null; then
    zle      -N     fzf-history-widget
    bindkey '^R'    fzf-history-widget
  else
    zle      -N     fzf-atuin-history-widget
    bindkey '^R'    fzf-atuin-history-widget
  fi
}

atuin-setup

# vim:ft=zsh ts=2 sw=2 et:
