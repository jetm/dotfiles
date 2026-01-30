-- Filetype detection configuration
-- Loaded early before lazy.nvim to ensure proper detection

vim.filetype.add({
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
  filename = {},
  pattern = {
    [".*%.bb%..*"] = "bitbake",
    [".*%.inc"] = "bitbake",
    [".*%.bats"] = "bash",
    [".*%.zsh"] = "sh",
    [".*%.rules"] = "udevrules",
    [".*%.service"] = "systemd",
    -- Age encrypted files: handled by age-secret.nvim plugin
    -- Filetype "age" allows nvim-lint skip pattern to work
    [".*%.age$"] = "age",
  },
})

-- Content-based filetype detection for uv run shebangs
-- Uses BufReadPost since file content isn't available during pattern matching
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*",
  callback = function(args)
    -- Only check files without a detected filetype or generic ones
    local ft = vim.bo[args.buf].filetype
    if ft ~= "" and ft ~= "conf" and ft ~= "text" then
      return
    end
    local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] or ""
    if first_line:match("^#!.*uv run") then
      vim.bo[args.buf].filetype = "python"
    end
  end,
})
