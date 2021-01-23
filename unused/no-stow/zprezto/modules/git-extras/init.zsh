#
# Provides completion for Git-Extras functions
#
#
# Authors:
#   Javier Tiá <javier.tia@gmail.com>
#

# Return if requirements are not found
if (( ! $+commands[git-extras] )); then
  return 1
fi

# Load dependencies
pmodload 'helper'

# Source module files
source "${0:h}/git-extras.zsh"
