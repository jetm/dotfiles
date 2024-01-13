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

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Apply changes in chezmoi managed files
autocmd("BufWritePost", {
  pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*",
  command = "silent !chezmoi apply --source-path %",
})

-- Disable diagnostics in insert mode
autocmd('ModeChanged', {
  pattern = {'n:i', 'v:s'},
  desc = 'Disable diagnostics in insert and select mode',
  callback = function(e) vim.diagnostic.disable(e.buf) end
})

autocmd('ModeChanged', {
  pattern = 'i:n',
  desc = 'Enable diagnostics when leaving insert mode',
  callback = function(e) vim.diagnostic.enable(e.buf) end
})

local function hide_semantic_highlights()
  for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

autocmd('ColorScheme', {
  desc = 'Clear LSP highlight groups',
  callback = hide_semantic_highlights,
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

autocmd("BufWritePre", {
  desc = "Automatically create parent directories if they don't exist when saving a file",
  group = augroup("create_dir"),
  callback = function(args)
    if args.match:match "^%w%w+://" then return end
    vim.fn.mkdir(vim.fn.fnamemodify(vim.loop.fs_realpath(args.match) or args.match, ":p:h"), "p")
  end,
})
