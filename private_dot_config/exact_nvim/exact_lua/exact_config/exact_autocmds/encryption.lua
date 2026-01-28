-- Encryption autocmds: GPG and Age file handling
-- Security: disables shada, swapfile, undofile to prevent plaintext leakage
local loader = require("config.autocmds.loader")
local augroup = loader.augroup
local autocmd = loader.autocmd

--------------------------------------------------------------------------------
-- GPG Encryption (*.gpg files)
-- Based on https://gist.github.com/traut/cd19ae2817ab13e0bade1f8a9995029f
-- Uses undo-based restore after write
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Age Encryption (*.age files)
-- Custom implementation - uses variable-based restore instead of undo
-- to prevent Neovim undo bug/crash
--------------------------------------------------------------------------------
local ageGroup = augroup("ageGroup")
local age_identity = vim.fn.expand("$HOME/.config/age/identity.key")
local age_recipient = "age15pv6yqycjhzs7x2jpafwce0qkvnjpkyrv77lrdsd5l4azt7zudzsmqedjs"

autocmd({ "BufReadPre", "FileReadPre" }, {
  pattern = "*.age",
  group = ageGroup,
  callback = function()
    vim.opt_local.shada = nil
    vim.opt_local.swapfile = false
    vim.opt_local.undofile = false
  end,
})

autocmd({ "BufReadPost", "FileReadPost" }, {
  pattern = "*.age",
  group = ageGroup,
  callback = function(ev)
    local filepath = vim.fn.expand("%:p")
    if vim.fn.filereadable(filepath) == 0 then
      return
    end

    -- Decrypt using rage (faster than age)
    local cmd = string.format("rage --decrypt -i %s %s 2>&1",
      vim.fn.shellescape(age_identity),
      vim.fn.shellescape(filepath))
    local content = vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to decrypt: " .. filepath .. "\n" .. content, vim.log.levels.ERROR)
      return
    end

    -- Replace buffer with decrypted content
    local lines = vim.split(content, "\n", { plain = true })
    if lines[#lines] == "" then table.remove(lines) end
    vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
    vim.bo[ev.buf].modified = false

    -- Trigger filetype detection for inner file
    local basename = vim.fn.expand("%:r")
    vim.cmd("doautocmd BufReadPost " .. vim.fn.fnameescape(basename))
  end,
})

autocmd({ "BufWritePre", "FileWritePre" }, {
  pattern = "*.age",
  group = ageGroup,
  callback = function(ev)
    -- Store plaintext for restoration (AVOIDS using undo)
    vim.b[ev.buf].age_plaintext = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)

    local content = table.concat(vim.b[ev.buf].age_plaintext, "\n") .. "\n"

    -- Encrypt content
    local cmd = string.format("rage --encrypt -r %s -a 2>&1",
      vim.fn.shellescape(age_recipient))
    local encrypted = vim.fn.system(cmd, content)

    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to encrypt: " .. encrypted, vim.log.levels.ERROR)
      return
    end

    -- Replace buffer with encrypted content for disk write
    local lines = vim.split(encrypted, "\n", { plain = true })
    if lines[#lines] == "" then table.remove(lines) end
    vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
  end,
})

autocmd({ "BufWritePost", "FileWritePost" }, {
  pattern = "*.age",
  group = ageGroup,
  callback = function(ev)
    -- Restore plaintext from variable (NOT using undo - avoids Neovim bug!)
    if vim.b[ev.buf].age_plaintext then
      vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, vim.b[ev.buf].age_plaintext)
      vim.b[ev.buf].age_plaintext = nil
      vim.bo[ev.buf].modified = false
    end
  end,
})
