#!/usr/bin/env bash
# Install fisher plugin manager for fish shell
set -euo pipefail

if ! command -v fish &>/dev/null; then
  echo "fish not installed, skipping fisher bootstrap"
  exit 0
fi

if ! fish -c "type -q fisher" 2>/dev/null; then
  echo "Installing fisher..."
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi

# Install plugins from fish_plugins file
if fish -c "type -q fisher" 2>/dev/null; then
  echo "Installing fish plugins from fish_plugins..."
  fish -c "fisher update"
fi

# Generate completions for installed tools
echo "Generating fish completions..."
completions_dir="${XDG_CONFIG_HOME:-$HOME/.config}/fish/completions"
mkdir -p "$completions_dir"
command -v chezmoi &>/dev/null && chezmoi completion fish >"$completions_dir/chezmoi.fish"
command -v atuin &>/dev/null && atuin gen-completions --shell fish --out-dir "$completions_dir/"
command -v starship &>/dev/null && starship completions fish >"$completions_dir/starship.fish"
