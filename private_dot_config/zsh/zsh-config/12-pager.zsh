# shellcheck disable=SC2148
#
# less pager
#
unset LESS

# -F quit if one screen
LESS="--quit-if-one-screen"

# -g highlight only last match for searches
LESS="${LESS} --hilite-search"

# -i ignore case
LESS="${LESS} --ignore-case"

# -M
LESS="${LESS} --long-prompt"

# -R raw
LESS="${LESS} --raw-control-chars"

# # -S
# LESS="${LESS} --chop-long-lines"

# -w
LESS="${LESS} --hilite-unread"

# -X
LESS="${LESS} --no-init"

LESS="${LESS} -z-4"

# --incsearch incremental search
LESS="${LESS} --incsearch"

# --no-histdups remove duplicates from command history
LESS="${LESS} --no-histdups"

# -~ --tilde Don't display tildes after end of file
LESS="${LESS} --tilde"

# -q Don't ring the terminal bell in all such cases
LESS="${LESS} --quiet"

# -s Causes consecutive blank lines to be squeezed into a single blank line
LESS="${LESS} --squeeze-blank-lines"
export LESS="${LESS}"

#
# PAGER
#
export PAGER=less
