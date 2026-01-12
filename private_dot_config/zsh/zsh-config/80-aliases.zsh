# shellcheck disable=SC2148
# Remove all aliases
unalias -m '*'

# Put just after removing all aliases
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd j)"

# Disable correction
alias type='type -a'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias mkdir='mkdir -p'

# lsd
alias ls='lsd --group-directories-first'
alias l='ls --all --long --header'

# General
alias e='nvim'
alias vimdiff='nvim -d'
alias up='bd'
# alias ..='cd ../'
alias cd-='cd -'
alias df='duf'
alias bbk='bitbake'
alias pacdiff="DIFFPROG='nvim -d' pacdiff -s"
alias zprofrc="ZPROFRC=1 zsh"
alias host=dog

#
# Git
#
alias g='git'

# Branch (b)
alias gb='git branch'
alias gbd='git branch -D'
alias gbv='git branch -vv'
alias gbm='git branch -M'
alias gs='git switch'
alias gsc='git switch -c'
alias gs-='git switch -'

# Commit (c)
alias gc='git commit -s'
alias gcm='git commit -s -m'
alias gca='git commit -s --all'
alias gcf='git commit -s --amend'
alias gcs='git show'

# Checkout (r)
alias grp='gai --patch=checkout --'
alias grr='gai --patch=reset --'
alias grf='git forgit checkout_file'
alias grh='git forgit reset_head'

# Grep (g)
alias gg='git grep'

# Index (a)
alias ga='git forgit add'
alias gap='gai --patch --'

# Diff (d)
alias gd='git forgit diff'
alias gdc='git forgit diff --cached'

# Log (l)
alias gl='git lg'
alias gla='git last'
alias gll='git lol'

# Push (p)
alias gp='git push'
alias gpf='git push -f'
alias gpr='git publish -t'

# Rebase (r)
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'
alias gro='git rebase-origin'

# Stash (S)
alias gS='git stash'
alias gSd='git stash drop'
alias gSp='git stash pop'
alias gSs='git stash show'
alias gSP='git stash --patch'

# Undo (u)
alias gu='git undo'
alias guh='git undo -h'

# Misc
alias gfc='git forgit fixup'
alias gcl='git clone'
alias gfe='git fetch'
alias gls='git ls-files'
alias gP='git pull'
alias gt='git status'

# xdg
alias svn='svn --config-dir $XDG_CONFIG_HOME/subversion'
alias units='units --history $XDG_DATA_HOME/units_history -u si'
alias wget='wget --hsts-file $XDG_DATA_HOME/wget-hsts'

#
# Arch Linux Stuff
#
if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
  #
  # Pacman aliases
  #

  # Recursively removing orphans (be careful)
  alias paorph='sudo pacman -Rs $(pacman -Qtdq)'

  # Remove ALL packages from cache
  alias paremALL='sudo pacman -Scc'

  if (command -v pikaur > /dev/null 2>&1); then
    # Remove the specified package(s), its configuration(s) and unneeded
    # dependencies
    alias parem='pikaur -Rns'

    # Upgrade all packages
    alias paud='pikaur -Syu'

    # Install specific package(s) from local and AUR
    alias pain='pikaur -S'

    # Install specific package from source package
    alias pains='pikaur -U'

    # Search for package(s) for local and AUR
    alias pasp='pikaur'
  fi

  if (command -v paccache > /dev/null 2>&1); then
    alias paclear='sudo paccache -rvk3'
  fi
fi
