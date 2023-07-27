local function augroup(name)
  return vim.api.nvim_create_augroup("yet_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings:
--------------------

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("YankHighlight"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = "500" })
  end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "nofile",
    "floaterm",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
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
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

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

-- Apply changes in chezmoi managed files
autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*",
  command = "silent !chezmoi apply --source-path %",
})

-- Terminal settings:
---------------------

-- Open a Terminal on the right tab
autocmd("CmdlineEnter", {
  command = "command! Term :botright vsplit term://$SHELL",
})

-- Enter insert mode when switching to terminal
autocmd("TermOpen", {
  command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

autocmd("TermOpen", {
  pattern = "",
  command = "startinsert",
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
  pattern = "term://*",
  command = "stopinsert",
})
