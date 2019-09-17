source ~/.aliases.fish

set --global --export EDITOR 'vim'
set --global --export VISUAL 'vim'
set --global --export PAGER 'less'

# Set the default Less options
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing)
# Remove -X and -F (exit if the content fits on one screen) to enable it
set --global --export LESS '-F -g -i -M -R -S -w -X -z-4'

# Set Go settings
set GO_PATH $HOME/go/bin
if test -d $GO_PATH
  if type -q go
    contains $GO_PATH $fish_user_paths
    or set --universal fish_user_paths $GO_PATH $fish_user_paths
  end
end

# Set ccache path
set CCACHE_PATH /usr/lib/ccache/bin
if test -d $CCACHE_PATH
  contains $CCACHE_PATH $fish_user_paths
  or set --universal fish_user_paths $CCACHE_PATH $fish_user_paths

  mkdir -p /dev/shm/ccache
    or echo "error: /dev/shm/ccache could not be created" 1>&2
end

# Set bin settings
set HOME_BIN $HOME/bin
if test -d $HOME_BIN
  contains $HOME_BIN $fish_user_paths
  or set --universal fish_user_paths $HOME_BIN $fish_user_paths
end

# Command-line fuzzy finder
if type -q fzf
  if type -q bat
    function preview --description 'preview files in fzf'
      fzf --preview 'bat --color \"always\" {}'
    end
  end

  if type -q fd
    set _FD "fd --hidden --follow --exclude '.git'"
    set --global --export FZF_CTRL_T_COMMAND "$_FD --type f"
    set --global --export FZF_ALT_C_COMMAND "$_FD --type d"
  end
end

# keychain settings
if status --is-interactive
  if type -q keychain
    keychain --quiet --agents ssh id_rsa
  end
end

begin
    set -l HOSTNAME (hostname)
    if test -f ~/.keychain/$HOSTNAME-fish
        source ~/.keychain/$HOSTNAME-fish
    end
end

#
# Python environment
#
# set --erase PYTHONPATH

# Set Bitbake Python path
set BITBAKE_PYTHON_PATH /usr/lib/python3.7/site-packages/bb
if test -d $BITBAKE_PYTHON_PATH
  and not contains $BITBAKE_PYTHON_PATH $PYTHONPATH
  set --export --universal PYTHONPATH \
    $BITBAKE_PYTHON_PATH \
    $PYTHONPATH
end

# vim:set ts=2 sw=2 ft=fish et:
