function fzf_ripgrep --description "Interactive ripgrep + fzf search"
    set -l RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
    set -l INITIAL_QUERY (commandline)

    command rm -f /tmp/rg-fzf-{r,f}
    FZF_DEFAULT_COMMAND="$RG_PREFIX \"$INITIAL_QUERY\"" fzf \
        --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1 && $RG_PREFIX {q} || true" \
        --prompt '  ripgrep > ' \
        --ghost='Search content...' \
        --delimiter : \
        --header 'Ctrl-r ripgrep | Ctrl-f fzf | Alt-n scope' \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'nohidden,<60(nohidden,up,60%,border-bottom,+{2}+3/3,~3)' \
        --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(  fzf > )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
        --bind "ctrl-r:unbind(ctrl-r)+change-prompt(  ripgrep > )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
        --bind "start:unbind(ctrl-r)" \
        --bind "alt-n:transform-nth(bash -c 'if [[ -z \$FZF_NTH ]]; then echo 1; elif [[ \$FZF_NTH == 1 ]]; then echo 4..; else echo \"\"; fi')+transform-prompt(bash -c 'if [[ -z \$FZF_NTH ]]; then echo \"  file > \"; elif [[ \$FZF_NTH == 1 ]]; then echo \"  content > \"; else echo \"  fzf > \"; fi')" \
        --bind "enter:become($EDITOR {1} +{2})"

    commandline -f repaint
end
