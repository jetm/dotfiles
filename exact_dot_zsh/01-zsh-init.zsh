# shellcheck disable=SC2148

# If I could disable Ctrl-s completely I would!
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Avoid problem with HEAD^
setopt NO_NOMATCH

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Time format using zsh time builtin
export TIMEFMT="Time: %E"

#
# less pager
#
unset LESS

# -F quit if one screen
LESS="--quit-if-one-screen"

# -g highlight only last match for searches
LESS="${LESS} --hilite-search"

# -i ignore case
LESS="${LESS} --ignore-case"

# -M
LESS="${LESS} --long-prompt"

# -R raw
LESS="${LESS} --raw-control-chars"

# # -S
# LESS="${LESS} --chop-long-lines"

# -w
LESS="${LESS} --hilite-unread"

# -X
LESS="${LESS} --no-init"

LESS="${LESS} -z-4"

# --incsearch incremental search
LESS="${LESS} --incsearch"

# --no-histdups remove duplicates from command history
LESS="${LESS} --no-histdups"

# -~ --tilde Don't display tildes after end of file
LESS="${LESS} --tilde"

export LESS="${LESS}"

#
# PAGER
#
export PAGER=less

#
# Man Pages
#
if command -v nvim &> /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

NPROC=$(nproc)
export SSTATE_DIR=~/repos/work/cache/sstate \
  DL_DIR=~/repos/work/cache/downloads \
  NPROC

git_extras=/usr/share/doc/git-extras/git-extras-completion.zsh

if [ -f "${git_extras}" ]; then
  # shellcheck disable=SC1090
  source "${git_extras}"
fi

run_compinit() {
    # run compinit in a smarter, faster way
    emulate -L zsh
    setopt localoptions extendedglob

    autoload -Uz compinit

    # if compdump is less than 20 hours old,
    # consider it fresh and shortcut it with `compinit -C`
    #
    # Glob magic explained:
    #   #q expands globs in conditional expressions
    #   N - sets null_glob option (no error on 0 results)
    #   mh-20 - modified less than 20 hours ago
    ZSH_COMPDUMP="${HOME}/.zcompdump"
    if [[ "$1" != "-f" ]] && [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
        # -C (skip function check) implies -i (skip security check).
        compinit -C -d "$ZSH_COMPDUMP"
    else
        compinit -i -d "$ZSH_COMPDUMP"
        touch "$ZSH_COMPDUMP"
    fi

    # Compile zcompdump, if modified, in background to increase startup speed.
    {
        if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
            zcompile "$ZSH_COMPDUMP"
        fi
    } &!
}
if ! zstyle -t ':zshzoo:plugin:compinit' defer; then
    run_compinit
fi

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

TRAPUSR1() { rehash }

# vim:set ts=2 sw=2 et:
