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

srt_extract() {
  mkvextract tracks "$1" $2:"$(basename $1 .mkv)".srt
}

audio_rm() {
  # ffmpeg -i "$1" -map 0 -map -0:a -map 0:m:language:$2 -c copy "$(basename $1 .mkv)_$2.mkv"
  ffmpeg -i "$1" -map 0:v -map 0:a:"$2" -c copy "$(basename $1 .mkv)_$2.mkv"
}

add_path() {
  if [ -d $1 ]; then
    # Set the list of directories that Zsh searches for programs
    path=($1 ${path})
  fi
}

list_path() { echo "${PATH//:/\\n}"; }

# In case a command is not found, try to find the package that has it
if (command -v filkoll > /dev/null 2>&1); then
  source /usr/share/doc/filkoll/command-not-found.zsh
fi

# vim:set ft=sh ts=2 sw=2 et:
