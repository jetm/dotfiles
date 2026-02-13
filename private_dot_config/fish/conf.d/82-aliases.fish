# Aliases (transparent, no inline expansion)

# Cleanup: erase all alias-created wrapper functions before redefining
# Fish aliases have description "alias name=..." - detect and erase them
for _fn in (functions --names)
    if string match -q 'alias *' -- (functions -D $_fn)
        functions --erase $_fn
    end
end

# Safety
alias rm 'rm -i'
alias mv 'mv -i'
alias cp 'cp -i'
alias ln 'ln -i'
alias mkdir 'mkdir -p'
alias type 'type -a'

# Listing (avoid long eza expansion in abbreviations)
alias ls 'eza --group-directories-first --icons=always'
alias l 'eza --all --long --header'

# XDG overrides
alias svn 'svn --config-dir $XDG_CONFIG_HOME/subversion'
alias units 'units --history $XDG_DATA_HOME/units_history -u si'
alias wget 'wget --hsts-file $XDG_DATA_HOME/wget-hsts'
