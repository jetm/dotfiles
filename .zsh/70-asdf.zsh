if [ ! -f /etc/arch-release ] || [ ! -f /etc/manjaro-release ]; then
  # https://github.com/asdf-vm/asdf-nodejs
  # nodejs \
  # issues with nodejs binaries are not found
  # export ASDF_NPM_DEFAULT_PACKAGES_FILE="$ASDF_DATA_DIR/npm-packages"; \
  # export NODEJS_CONFIGURE_OPTIONS="prefix=/users/tiamarin/.asdf/npm-packages ";' \
  local plugins_list_to_install=(
  # https://github.com/asdf-vm/asdf-ruby.git
  ruby
  # https://github.com/code-lever/asdf-rust
  rust
  # https://github.com/kennyp/asdf-golang
  golang
  # https://github.com/Stratus3D/asdf-lua.git
  lua
  )

  local installed_plugins=$(asdf plugin list)

  for plugin in $plugins_list_to_install; do
      if [[ "$installed_plugins" != *"$plugin"* ]]; then
          command asdf plugin add $plugin
          print -P "%F{blue}Added plugin for %K{white} $plugin %k and now installing the latest version...%f"
          if [[ "$plugin" == "nodejs" ]]; then
              bash -c "$ASDF_DATA_DIR/plugins/nodejs/bin/import-release-team-keyring"
          fi
          command asdf install $plugin latest
          command asdf global $plugin latest
          command asdf reshim $plugin
          print -P "%F{green}Finished installing the lastest version with asdf %K{white} $plugin %k%f."
      fi
  done
fi

# vim:set ts=2 sw=2 et:
