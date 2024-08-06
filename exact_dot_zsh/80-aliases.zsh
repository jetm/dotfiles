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
alias l='ls --all --long --header --git'

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
alias fix=fuck

#
# Git
#
alias g='git'

# Branch (b)
alias gb='git branch'
alias gbd='git branch -D'
alias gbv='git branch -vv'
alias gbm='git branch -M'

# Commit (c)
alias gc='git commit -s'
alias gcm='git commit -s -m'
alias gca='git commit --all'
alias gcf='git commit --amend -s'
alias gch='git cherry-pick -x'
alias gcs='git show'

# Checkout (c)
alias gsb='git switch'
alias grp='git restore --patch'
alias gsc='git switch -c'
alias gs-='git switch -'
alias gr-='git restore -'
alias gre='forgit::checkout::file'
alias grE='git rE'
alias grh='forgit::reset::head'

# Grep (g)
alias gg='git grep'

# Index (a)
alias ga='forgit::add'
alias gap='git add --patch'

# Diff (d)
alias gd='forgit::diff'
alias gdc='forgit::diff --cached'

# Log (l)
alias gl='git lg'
alias gla='git last'
alias gll='git lol'

# Push (p)
alias gp='git push'
alias gpr='git publish -t'

# Rebase (r)
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gri='git rebase --interactive'

# Stash (s)
alias gs='git stash'
alias gsd='git stash drop'
alias gsp='git stash pop'
alias gss='git stash show'
alias gsP='git stash --patch'

# Undo (u)
alias gu='git undo'
alias guh='git undo -h'

# rest
alias gfi='git fixup-prev-ci'
alias gcl='git clone'
alias gfe='git fetch'
alias gls='git ls-files'
alias gP='git pull'
alias gt='git status'

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

  if (command -v paru > /dev/null 2>&1); then
    # Remove the specified package(s), its configuration(s) and unneeded
    # dependencies
    alias parem='paru -Rns'

    # Upgrade all packages
    alias paud='paru -Syu --devel'

    # Install specific package(s) from local and AUR
    alias pain='paru -S'

    # Install specific package from source package
    alias pains='paru -U'

    # Search for package(s) for local and AUR
    alias pasp='paru'
  fi
fi
