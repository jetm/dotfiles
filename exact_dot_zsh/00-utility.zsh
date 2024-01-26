# shellcheck disable=SC2148

# debug bash script
debug() {
  local script="$1"; shift
  bash -x "$(which "$script")" "$@"
}

# Remove duplicates PATH
remove_PATH_duplicates() {
  if [ -n "$PATH" ]; then
    old_PATH=$PATH:; PATH=
    while [ -n "$old_PATH" ]; do
      x=${old_PATH%%:*}      # the first remaining entry
      case $PATH: in
        *:"$x":*) ;;         # already there
        *) PATH=$PATH:$x;;   # not there yet
      esac
      old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
    export PATH
  fi
}

add_path() {
  if [ -d $1 ]; then
    # Set the list of directories that Zsh searches for programs.
    path=($1 ${path})
  fi
}

aurgen() {
  if (! command -v updpkgsums > /dev/null 2>&1); then
    echo "error: updpkgsums is not installed" 1>&2
    return 1
  fi

  if (! command -v namcap > /dev/null 2>&1); then
    echo "error: namcap is not installed" 1>&2
    return 1
  fi

  if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
    # Validate PKGBUILD, update checksum package, build and generate .SCRINFO
    # file
    namcap PKGBUILD && \
      updpkgsums && \
      makepkg --cleanbuild --syncdeps --force && \
      makepkg --printsrcinfo >! .SRCINFO
  fi
}

# Colorize the `man` pages
# https://www.howtogeek.com/683134/how-to-display-man-pages-in-color-on-linux/
function man() {
  autoload -Uz colors
  colors
  # LESS_TERMCAP_md - Start bold effect (double-bright)
  # LESS_TERMCAP_me - Stop bold effect
  # LESS_TERMCAP_us - Start underline effect
  # LESS_TERMCAP_ue - Stop underline effect
  # LESS_TERMCAP_so - Start stand-out effect (similar to reverse text)
  # LESS_TERMCAP_se - Stop stand-out effect (similar to reverse text)
  # LESS_TERMCAP_mb - Start blink
  LESS_TERMCAP_md="${fg_bold[cyan]}" \
  LESS_TERMCAP_me="${reset_color}" \
  LESS_TERMCAP_us="${fg_bold[magenta]}" \
  LESS_TERMCAP_ue="${reset_color}" \
  LESS_TERMCAP_so="${fg_bold[white]}${bg[blue]}" \
  LESS_TERMCAP_se="${reset_color}" \
  LESS_TERMCAP_mb="${fg_bold[green]}" \
  command man "$@"
}

path() { echo "${PATH//:/\\n}"; }
silent() { "$@" > /dev/null 2>&1; }

move() {
  local ext=${2:-.bak}
  if [ -d "$1" ]; then
    echo "Error: $1 is a directory"
  else
    backup_file=${1}.${ext}
    mv "$1" "$backup_file"
  fi
}

# save-dotfiles - apply and commit dotfiles
#   usage: save-dotfiles "MESSAGE"
save-dotfiles() {
  local commit_message="${1:?"a commit message must be specified"}"
  echo "\n\n"
  echo $0 "local diff:"
  GIT_PAGER="cat" LESS="$LESS -FRXK" chezmoi --no-pager diff || echo "no diff"

  echo "\n\n"
  echo $0 "remote diff:"
  GIT_PAGER="cat" LESS="$LESS -FRXK" chezmoi --no-pager git --no-pager diff || echo "no diff"
  echo "\n\n"

  # http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-read
  if read -q "choice?continue? (Y/y): "; then
    echo
    echo $0 "updating dotfiles..."
    chezmoi git add .
    chezmoi git -- commit -m "${commit_message}"
    chezmoi git -- push origin main
    chezmoi apply
    reload-zsh
  else
    echo
    echo "'$choice' not 'Y' or 'y'. Skipping..."
  fi
}

# vim:set ft=sh ts=2 sw=2 et:
