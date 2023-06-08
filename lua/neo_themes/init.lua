local M = {}

M.setup = function(opts)
	print("Options")
	P(opts)
end

vim.api.nvim_create_user_command("ChangeTheme", function(opts)
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. opts.fargs[1])
	if not status_ok then
		vim.notify("Failed to load colorscheme", vim.log.levels.ERROR, { title = "No Color Scheme Found" })
		return
	end
end, {
	nargs = 1,
	complete = function()
		return { "ron", "catppuccin-mocha" }
	end,
})

print("Loaded data neo_themes")
return M
