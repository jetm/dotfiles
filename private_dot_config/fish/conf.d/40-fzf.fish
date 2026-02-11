# FZF configuration
# OneDark color theme
set -gx FZF_DEFAULT_OPTS "\
  --style=minimal
  --highlight-line
  --color=dark
  --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
  --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
  --color=border:#3e4452,nomatch:#5c6370,nth:italic
  --ghost='Search...'"

# forgit fzf options
set -gx FORGIT_FZF_DEFAULT_OPTS "$FORGIT_FZF_DEFAULT_OPTS --ansi --tabstop=2 --layout=reverse --style=minimal"

# fzf.fish plugin-specific variables (replaces FZF_CTRL_T_COMMAND etc.)
set -g fzf_fd_opts --hidden --exclude .git --exclude .repo --ignore
set -g fzf_preview_dir_cmd eza --all --group-directories-first --icons=always
set -g fzf_preview_file_cmd bat --color=always
set -g fzf_directory_opts --ghost='Search directories...'
