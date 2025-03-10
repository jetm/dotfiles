if [[ -f "${HOME}"/.cache/antidote/xvoland/Extract/extract.sh ]]; then
  source "${HOME}"/.cache/antidote/xvoland/Extract/extract.sh
fi

if [[ -x "${HOME}/.local/bin/mise" ]]; then
  eval "$(${HOME}/.local/bin/mise activate zsh)"
fi
