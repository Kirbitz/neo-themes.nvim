local utils = require("neo_themes.utils")
local completion = require("neo_themes.completion")

vim.api.nvim_create_user_command("ChangeTheme", function(opts)
	local theme = opts.fargs[1]
	utils.setColorScheme(theme)
end, {
	desc = "Changes the current colorscheme for the current session",
	nargs = 1,
	complete = function()
		return completion.options
	end,
})

vim.api.nvim_create_user_command("SetTheme", function(opts)
	local theme = opts.fargs[1]
	if utils.setColorScheme(theme) then
		local path = utils.pathJoin(vim.fn.stdpath("cache"), "neo_themes", "theme_pref")

		local file = io.open(path, "w+")
		if not file then
			vim.notify("Failed to open file", vim.log.levels.ERROR, { title = "IO Write Failure" })
			return
		end
		file:write(theme)
		file:close()
	end
end, {
	desc = "Sets prefered the current colorscheme for current and future session",
	nargs = 1,
	complete = function()
		return completion.options
	end,
})
