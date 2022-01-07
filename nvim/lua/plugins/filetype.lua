local status_ok, filetype = pcall(require, "filetype")
if not status_ok then
	return
end

-- In init.lua or filetype.nvim's config file
filetype.setup({
    overrides = {
        extensions = {
            -- Set the filetype of *.pn files to potion
            bb = 'bitbake',
            bbclass = 'bitbake',
            inc = 'bitbake',
            bbappend = 'bitbake'
        },
        literal = {
            -- Set the filetype of files named "MyBackupFile" to lua
            MyBackupFile = 'lua',
        },
        complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            [".*git/config"] = "gitconfig",  -- Included in the plugin
        },

        -- The same as the ones above except the keys map to functions
        function_extensions = {
            ["cpp"] = function()
                vim.bo.filetype = "cpp"
            end,
            ["pdf"] = function()
                vim.bo.filetype = "pdf"
            end,
        },
    }
})

