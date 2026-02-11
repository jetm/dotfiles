# Abbreviations (expand inline in history)

# Cleanup: erase all abbreviations before redefining
# This prevents stale abbreviations from persisting after removal from config
# Safe because no plugins create abbreviations (FORGIT_NO_ALIASES=1)
for _a in (abbr --list)
    abbr --erase $_a
end

# General
abbr -a e nvim
abbr -a vimdiff 'nvim -d'
abbr -a .. 'cd ../'
abbr -a cd- 'cd -'
abbr -a df duf
abbr -a bbk bitbake
abbr -a pacdiff "DIFFPROG='nvim -d' pacdiff -s"
abbr -a host doggo

# Git - General
abbr -a g git

# Git - Branch
abbr -a gb 'git branch'
abbr -a gbd 'git branch -D'
abbr -a gbv 'git branch -vv'
abbr -a gbm 'git branch -M'
abbr -a gs 'git switch'
abbr -a gsc 'git switch -c'
abbr -a gs- 'git switch -'

# Git - Commit
abbr -a gc 'git commit -s'
abbr -a gcm 'git commit -s -m'
abbr -a gca 'git commit -s --all'
abbr -a gcf 'git commit -s --amend'
abbr -a gcs 'git show'

# Git - Checkout/Reset (forgit)
abbr -a grp 'gai --patch=checkout --'
abbr -a grr 'gai --patch=reset --'
abbr -a grf 'git-forgit checkout_file'
abbr -a grh 'git-forgit reset_head'

# Git - Grep
abbr -a gg 'git grep'

# Git - Index (forgit)
abbr -a ga 'git-forgit add'
abbr -a gap 'gai --patch --'

# Git - Diff (forgit)
abbr -a gd 'git-forgit diff'
abbr -a gdc 'git-forgit diff --cached'

# Git - Log
abbr -a gl 'git lg'
abbr -a gla 'git last'
abbr -a gll 'git lol'

# Git - Push
abbr -a gp 'git push'
abbr -a gpf 'git push -f'
abbr -a gpr 'git publish -t'

# Git - Rebase
abbr -a gr 'git rebase'
abbr -a gra 'git rebase --abort'
abbr -a grc 'git rebase --continue'
abbr -a gri 'git rebase --interactive'
abbr -a gro 'git rebase-origin'

# Git - Stash
abbr -a gS 'git stash'
abbr -a gSd 'git stash drop'
abbr -a gSp 'git stash pop'
abbr -a gSs 'git stash show'
abbr -a gSP 'git stash --patch'

# Git - Undo
abbr -a gu 'git undo'
abbr -a guh 'git undo -h'

# Git - Misc
abbr -a gfc 'git-forgit fixup'
abbr -a gcl 'git clone'
abbr -a gfe 'git fetch'
abbr -a gls 'git ls-files'
abbr -a gP 'git pull'
abbr -a gt 'git status'
abbr -a gsm git-switch-main
