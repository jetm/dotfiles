# shellcheck disable=SC2148
#
# Global Key Bindings
#
# Use cat -v > /dev/null to know the keybinding
#

# <Ctrl+Right>  => Forward word -- Disabled
# <Ctrl+Left>   => Backward word -- Disabled
# <Ctrl+E>      => Edit command in $EDITOR
# <Ctrl+V>      => Paste from system clipboard -- Disabled
# <UP>          => History search up for substring
# <DOWN>        => History search down for substring
# <Ctrl+Z>      => Run fg
# <Alt+A>       => Search for alias
# <Alt+F>       => Search for functions -- Disabled
# <Ctrl+F>      => Grep in files
# <Ctrl+T>      => Search in history
# <Alt+S>       => Insert sudo word -- Disabled
# <Clrt+P>      => Search files
# <Alt+D>       => Delete branch
# <Ctrl+]>      => Clear screen and scrollback -- Disabled

# <Ctrl+Right> => Forward word
# bindkey "^[[1;5C" forward-word

# <Ctrl+Left> => Backward word
# bindkey "^[[1;5D" backward-word

# same behavior from bash for vi-mode
autoload edit-command-line
zle -N edit-command-line

# <Ctrl+E>
bindkey -M vicmd '^E' edit-command-line

bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down

# paste-from-clipboard() {
#   local clipboard
#   clipboard=$(cb paste 2> /dev/null | cat -)
#   BUFFER="$LBUFFER$clipboard$RBUFFER"
#   CURSOR="$(($CURSOR + ${#clipboard}))"
# }
# zle -N paste-from-clipboard

# <Ctrl+V>
# bindkey '^V' paste-from-clipboard
# bindkey '^[[2;2~' paste-from-clipboard

fancy-ctrl-z () {
  if [[ $#BUFFER = 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z

# <Ctrl+Z>
bindkey '^Z' fancy-ctrl-z

fzf-aliases-widget() {
  LBUFFER="$LBUFFER$(FZF_DEFAULT_COMMAND=
  alias | sed 's/=/ --- /' | \
    awk -F '---' \
      '{
        print $1 "--" $2
      }' | \
    tr -d "'" | column -tl2 | \
    fzf --prompt=" Aliases > " \
        --ansi \
        --preview 'echo {3..} | bat --color=always --plain --language=sh' \
        --preview-window 'up:4:nohidden:wrap' | cut -d' ' -f 1)"
  zle reset-prompt
}
zle -N fzf-aliases-widget

# <Alt+A>
bindkey '^[a' fzf-aliases-widget

# Workaround to avoid overwritten by zsh-vi-mode plugin
# <Ctrl+r>
bindkey -M viins '^r' fzf-history-widget

# fzf-functions-widget() {
#   # shellcheck disable=SC2034
#   LBUFFER="$LBUFFER$(FZF_DEFAULT_COMMAND=
#     # ignore functions starting with "_ . +"
#     # shellcheck disable=SC2296
#     print -l "${(ok)functions[(I)[^_.+]*]}" |
#       fzf -q "$LBUFFER" --ansi --prompt=" Functions > "
#   )"
#
#   zle reset-prompt
# }
# zle -N fzf-functions-widget

# <Alt+F>
# bindkey '^[f' fzf-functions-widget

_fzf-ripgrep_() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"

  fzf_options=(
    --ansi
    --color "hl:-1:underline,hl+:-1:underline:reverse"
    --disabled --query "$INITIAL_QUERY"
    --bind "change:reload:sleep 0.1 && $RG_PREFIX {q} || true"
    --prompt '  ripgrep > '
    --delimiter :
    --header 'Ctrl-r ripgrep mode | Ctrl-f fzf mode '
    --preview 'bat --color=always {1} --highlight-line {2}'
    --preview-window 'nohidden,<60(nohidden,up,60%,border-bottom,+{2}+3/3,~3)'
  )

  command rm -f /tmp/rg-fzf-{r,f}
  FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" fzf "${fzf_options[@]}" \
    --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(  fzf > )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
    --bind "ctrl-r:unbind(ctrl-r)+change-prompt(  ripgrep > )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
    --bind "start:unbind(ctrl-r)" \
    --bind "enter:become(${EDITOR:-vim} {1} +{2})"
}

fzf-ripgrep-widget() {
  _fzf-ripgrep_"$*" < "$TTY"
  zle redisplay
}
zle -N fzf-ripgrep-widget

# <Ctrl-F>
bindkey '^F' fzf-ripgrep-widget

exit_zsh() {
  exit
}
zle -N exit_zsh

# Make sure to always close zsh
bindkey '^D' exit_zsh

# ls automatically after cd and git status if on a git repo
function cd () {
  auto_ls() {
    if command -v lsd > /dev/null; then
      lsd --all --group-directories-first
    else
      ls -Fh --color=auto --group-directories-first
    fi
  }

  builtin cd "$@"

  if [[ -d .git ]]; then
    git status; echo ""
    auto_ls
  else
    auto_ls
  fi
}

# Insert sudo at the beggining of the line
# function insert_sudo() {
#   BUFFER="sudo $BUFFER"
#   zle end-of-line;
# }
# zle -N insert_sudo

# <Alt+S>
# bindkey '^[s' insert_sudo
# bindkey -M vicmd '^[s' insert_sudo
# bindkey -M viins '^[s' insert_sudo

# Delete Git branch
function forgit_delete_branch() {
  git-switch-default-branch
  forgit::branch::delete

  # show prompt
  zle redisplay
}
zle -N forgit_delete_branch

# <Alt+D>
bindkey '^[d' forgit_delete_branch

# <Ctrl+P>
bindkey -r '^P'
bindkey -r '^T'
bindkey -M vicmd '^p' fzf-file-widget
bindkey -M viins '^p' fzf-file-widget
bindkey '^P' fzf-file-widget

# Insert a last word
# bindkey -M viins '\e.' insert-last-word

# Iterate through arguments Ctrl + [ + ] (N times)
# autoload -Uz copy-earlier-word
# zle -N copy-earlier-word
# bindkey -M viins "^[m" copy-earlier-word

custom_clear_screen() {
  builtin print -rn -- $'\r\e[0J\e[H\e[22J' >"$TTY"
  builtin zle .reset-prompt
  builtin zle -R
}
zle -N custom_clear_screen

# Conflict with Ctrl+l to change Kitty windows
bindkey '^n' custom_clear_screen

# bindkey '^x' create_completion

# clear_screen_and_scrollback() {
#     echoti civis >"$TTY"
#     printf '%b' '\e[H\e[2J' >"$TTY"
#     zle .reset-prompt
#     zle -R
#     printf '%b' '\e[3J' >"$TTY"
#     echoti cnorm >"$TTY"
#     reset
# }

# zle -N clear_screen_and_scrollback
# bindkey '^]' clear_screen_and_scrollback

#
# zsh-abbr
#
# bindkey -M viins " " abbr-expand-and-space
# bindkey -M viins "^ " magic-space
# bindkey -M viins "^M" abbr-expand-and-accept

# vim:set ft=zsh ts=2 sw=2 et:
