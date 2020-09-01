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

# vim:set ts=2 sw=2 et:
