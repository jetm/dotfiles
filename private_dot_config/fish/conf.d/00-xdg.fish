# XDG Base Directories
set -gx XDG_BIN_HOME $HOME/.local/bin
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_RUNTIME_DIR; or set -gx XDG_RUNTIME_DIR $HOME/.local/run
set -gx XDG_STATE_HOME $HOME/.local/state
