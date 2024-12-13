if vim.g.vscode then
  return
end

local function augroup(name)
  return vim.api.nvim_create_augroup("yet_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings:
--------------------

-- WAR: E21: Cannot make changes, 'modifiable' is off
-- autocmd({ "BufReadPost" }, {
--   pattern = "",
--   callback = function()
--     vim.cmd("if &modifiable | set modifiable | set write | endif")
--   end,
-- })

-- user event that loads after UIEnter + only if file buf is there
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if not vim.g.ui_entered and args.event == "UIEnter" then
      vim.g.ui_entered = true

      -- Firenvim
      local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
      if client ~= nil and client.name == "Firenvim" then
        vim.o.laststatus = 0
        vim.o.cmdheight = 0
      end
    end

    if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
      vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
      vim.api.nvim_del_augroup_by_name("NvFilePost")

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})

        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank({ higroup = "IncSearch", timeout = "300" })
  end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local exclude = { "gitcommit", "gitrebase" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, "\"")
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Apply changes in chezmoi managed files
autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*",
  command = "silent !chezmoi apply --source-path %",
})

-- Disable diagnostics in insert mode
autocmd("ModeChanged", {
  pattern = { "n:i", "v:s" },
  desc = "Disable diagnostics while typing",
  callback = function(e)
    vim.diagnostic.enable(false, { bufnr = e.buf })
  end,
})

autocmd("ModeChanged", {
  pattern = "i:n",
  desc = "Enable diagnostics when leaving insert mode",
  callback = function(e)
    vim.diagnostic.enable(true, { bufnr = e.buf })
  end,
})

-- local function hide_semantic_highlights()
--   for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--     vim.api.nvim_set_hl(0, group, {})
--   end
-- end
--
-- autocmd("ColorScheme", {
--   desc = "Clear LSP highlight groups",
--   callback = hide_semantic_highlights,
-- })

--
-- Settings for filetypes:
--

-- Set indentation to 2 spaces
autocmd("Filetype", {
  group = augroup("setIndent"),
  pattern = { "yaml", "lua" },
  command = "setlocal shiftwidth=2 tabstop=2 sts=2 expandtab",
})

-- Show by default 4 spaces for a tab
autocmd("Filetype", {
  group = augroup("setIndent"),
  pattern = { "go" },
  command = "setlocal shiftwidth=4 tabstop=4 sts=4 noexpandtab",
})

-- Enable wrap
autocmd("Filetype", {
  group = augroup("wrap"),
  pattern = { "markdown", "gitcommit" },
  command = "setlocal wrap",
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
  group = augroup("spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "floaterm",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "nofile",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Based on https://gist.github.com/traut/cd19ae2817ab13e0bade1f8a9995029f
local gpgGroup = augroup("gpgGroup")

-- autocmds execute in the order in which they were defined.
-- https://neovim.io/doc/user/autocmd.html#autocmd-define

autocmd({ "BufReadPre", "FileReadPre" }, {
  pattern = "*.gpg",
  group = gpgGroup,
  callback = function()
    -- Make sure nothing is written to shada file while editing an encrypted file.
    vim.opt_local.shada = nil
    -- We don't want a swap file, as it writes unencrypted data to disk
    vim.opt_local.swapfile = false
    -- Switch to binary mode to read the encrypted file
    vim.opt_local.bin = true

    vim.cmd("let ch_save = &ch|set ch=2")
  end,
})

autocmd({ "BufReadPost", "FileReadPost" }, {
  pattern = "*.gpg",
  group = gpgGroup,
  callback = function()
    vim.cmd("'[,']!gpg --decrypt 2> /dev/null")

    -- Switch to normal mode for editing
    vim.opt_local.bin = false

    vim.cmd("let &ch = ch_save|unlet ch_save")
    vim.cmd(":doautocmd BufReadPost " .. vim.fn.expand("%:r"))
  end,
})

-- Convert all text to encrypted text before writing
autocmd({ "BufWritePre", "FileWritePre" }, {
  pattern = "*.gpg",
  group = gpgGroup,
  command = "'[,']!gpg --default-recipient-self -ae 2>/dev/null",
})
-- Undo the encryption so we are back in the normal text, directly
-- after the file has been written.
autocmd({ "BufWritePost", "FileWritePost" }, {
  pattern = "*.gpg",
  group = gpgGroup,
  command = "u",
})

vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > vim.g.bigfile_size
            and "bigfile"
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("bigfile"),
  pattern = "bigfile",
  callback = function(ev)
    vim.b.minianimate_disable = true
    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
