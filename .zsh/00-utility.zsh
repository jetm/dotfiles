# debug bash script
debug() {
  local script="$1"; shift
  bash -x "$(which "$script")" "$@"
}

# vim:set ts=2 sw=2 et:
