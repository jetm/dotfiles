local function prettier()
	return {
		exe = "prettier",
		args = {
			"--stdin-filepath",
			vim.api.nvim_buf_get_name(0),
			"--single-quote",
		},
		stdin = true,
	}
end

local function shfmt()
	return {
		exe = "shfmt",
		args = { "-sr", "-i 4", "-ci", "-s" },
		stdin = true,
	}
end

local function luaformat()
	return {
		exe = "stylua",
		args = {
			"--column-width 80",
			"-",
		},
		stdin = true,
	}
end

require("formatter").setup({
	logging = false,
	filetype = {
		markdown = { prettier },
		json = { prettier },
		yaml = { prettier },
		sh = { shfmt },
		bash = { shfmt },
		lua = { luaformat },
	},
})
