local M = {
  "norcalli/nvim-colorizer.lua",
}

function M.config()
  local ok, colorizer = pcall(require, "colorizer")
  if not ok then
    error("Loading colorizer")
    return
  end

  -- Attaches to every FileType mode
  colorizer.setup({ "*" }, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  })
end

return M
