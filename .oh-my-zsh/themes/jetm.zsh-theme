git_dotfiles_branch() {
  local br=$(cd ~/repos/dotfiles && git symbolic-ref --short HEAD)
  local d=$(git config --get user.email | grep -P -o '\@\K.*')

  if [[ "${br}" == "master" ]]; then
    echo "${d}(⌂)"
  else
    echo "${d}(⚒ )"
  fi
}

PROMPT=$'%{$fg_bold[green]%}%n@%m.$(git_dotfiles_branch):%{$fg[blue]%}%~ $(git_prompt_info)\
%{$reset_color%}$ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

