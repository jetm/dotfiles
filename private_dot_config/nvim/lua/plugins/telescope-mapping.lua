local M = {}

function M.find_files()
	local opts = {
		prompt_title = "~ files ~",
		find_command = {
			"fd",
			"--hidden",
			"--type=file",
			"--type=symlink",
			"--exclude=.git",
			"--ignore-case",
			"--color=never",
		},
	}

	require("telescope.builtin").find_files(opts)
end

function M.search_dirs(search_directory)
	local opts = {
		prompt_title = "~ search dir ~",
		find_command = {
			"fd",
			"-ipH",
			"-t=f",
			"--search-path=" .. search_directory,
		},
		previewer = false,
	}
	require("telescope.builtin").find_files(opts)
end

function M.search_changed_files()
	local opts = {
		prompt_title = "~ changed files ~",
		previewer = false,
		find_command = {
			"git",
			"diff",
			"--name-only",
			"--diff-filter=ACMRT",
			"HEAD",
		},
	}

	require("telescope.builtin").find_files(opts)
end

return M
