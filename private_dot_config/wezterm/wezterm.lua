local wezterm = require("wezterm")
wezterm.log_info("reloading")

local config = wezterm.config_builder()

config.scrollback_lines = 9999999

config.default_prog = { "tmux", "attach", "-t", "vm" }

config.color_scheme = "OneHalfDark"
config.font = wezterm.font("Noto Mono Nerd Font")
config.font_size = 11
config.warn_about_missing_glyphs = false

config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.default_gui_startup_args = { "connect", "dropdown" }
config.unix_domains = { { name = "dropdown" } }

config.disable_default_key_bindings = true

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = "https://www.github.com/$1/$3",
})

return config
