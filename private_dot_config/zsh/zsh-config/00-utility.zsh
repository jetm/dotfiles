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

extract_srt() {
  srt_id=$(( $2 - 1 ))
  mkvextract tracks "$1" $srt_id:"$(basename $1 .mkv)".srt
}

rm_audio() {
  # ffmpeg -i "$1" -map 0 -map -0:a -map 0:m:language:$2 -c copy "$(basename $1 .mkv)_$2.mkv"
  audio_id=$(( $2 - 1 ))
  ffmpeg -i "$1" -map 0:v -map 0:a:"$audio_id" -c copy "$(basename $1 .mkv)_$audio_id2.mkv"
}

extract_audio() {
    local input_file="$1"

    # Validate input
    if [[ -z "$input_file" ]]; then
        echo "Usage: extract_english_mkv <mkv_file>"
        return 1
    fi

    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found"
        return 1
    fi

    # Get audio stream information
    local audio_info=$(mediainfo --Output="Audio;%StreamKindPos%:%Language/String3% " "$input_file")

    if [[ -z "$audio_info" ]]; then
        echo "Error: No audio streams found in '$input_file'"
        return 1
    fi

    # Find English stream position
    local eng_stream=$(echo "$audio_info" | grep -o '[0-9]*:eng' | cut -d: -f1)

    if [[ -z "$eng_stream" ]]; then
        echo "Error: No English audio stream found in '$input_file'"
        echo "Available streams: $audio_info"
        return 1
    fi

    # Convert to 0-based indexing for ffmpeg
    local ffmpeg_audio_index=$((eng_stream - 1))

    # Generate output filename
    local output_file="${input_file%.*}_eng.${input_file##*.}"

    echo "Extracting English audio stream (position $eng_stream) from '$input_file'..."

    # Extract with ffmpeg - copy video and specified audio stream
    ffmpeg -i "$input_file" -map 0:v -map 0:a:$ffmpeg_audio_index -c copy "$output_file"

    if [[ $? -eq 0 ]]; then
        echo "Successfully created '$output_file' with English audio only"
    else
        echo "Error: Failed to create output file"
        return 1
    fi
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
