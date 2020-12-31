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

mvI() {
  if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
    command mv "$@"
    return
  fi

  newfilename="$1"
  vared newfilename
  command mv -v -- "$1" "$newfilename"
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

# =========================================================================== #
# `quote` - pick a random quote from http://www.quotationspage.com/
# --------------------------------------------------------------
# NOTE: Inspired by and borrowed from OMZ plugin:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rand-quote/rand-quote.plugin.zsh
# =========================================================================== #
quote() {
  emulate -L zsh
  # make the GET request and extract the output
  request=$(curl -s --connect-timeout 2 "http://www.quotationspage.com/random.php" \
    | iconv -c -f ISO-8859-1 -t UTF-8 \
    | grep -m 1 "dt ")
  sentence=$(echo "$request" | sed -e 's/<\/dt>.*//g' -e 's/.*html//g' -e 's/^[^a-zA-Z]*//' -e 's/<\/a..*$//g')
  author=$(echo "$request" | sed -e 's/.*\/quotes\///g' -e 's/<.*//g' -e 's/.*">//g')
  # if request sucessfull, print it
  if [[ -n "$author" && -n "$sentence" ]]; then
    print "${sentence}\n\n-- [${author}]"
  fi
}

# =========================================================================== #
# Colorize the `man` pages
# ------------------------
# https://www.howtogeek.com/683134/how-to-display-man-pages-in-color-on-linux/
# =========================================================================== #
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

# =========================================================================== #
# `where $1` - ($1 - name of the command) show the location of the executable
#        file and completion if this command have them
# =========================================================================== #
where() {
  if (( $+commands[$1] )); then
    print -P "%F{blue}Executable file location:%f $(which $1)"
    if [[ $_comps[$1] ]]; then
      print -P "%F{magenta}Completion file location:%f $(echo $^fpath/$_comps[$1](N))"
    else
      print -P '%F{yellow}This command has no completions installed.%f'
    fi
  else
    print -P '%F{red}The command "$1" does not exist!%f'
  fi
}

# =========================================================================== #
# `palette` - print palette and color codes (for percentage expansion)
# =========================================================================== #
palette() {
  local colors
  if [[ $1 == "background" || $1 == "bg" ]]; then
    for n in {000..255}; do
      colors+=("%K{$n}   %k%F{$n}$n%f")
    done
  else
    for n in {000..255}; do
      colors+=("%F{$n}$n%f")
    done
  fi
  print -Pc $colors
}

# =========================================================================== #
# `where_zsh` - find the mentioned word ($1) anywhere in Zsh configuration.
#       It can be alias, command, commented word or anything. It will
#       use best available searching tool
# =========================================================================== #
where_zsh() {
  local searcher_cmd
  if (( $+commands[ag] )); then
    searcher_cmd='ag'
  elif (( $+commands[rg] )); then
      searcher_cmd="rg"
  elif (( $+commands[ack] )); then
    searcher_cmd="ack"
  else
    searcher_cmd="grep"
  fi
  local results
  # Explanation of flags:
  # `-i` - force shell to be interactive
  # `-c` - take the first argument as a command to execute
  # `-x` - equivalent to `--xtrace`
  results="$(zsh -ixc : 2>&1 | $searcher_cmd $1)"
  if [ $results ]; then
    print -P "%F{green}Found in:%f"
    print -l $results | nl | h $1
  else
    print -P "%F{red}It wasn't defined or mentioned anywhere in Zsh configurations.%f"
  fi
}

# vim:set ts=2 sw=2 et:
