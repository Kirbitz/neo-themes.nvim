vim.api.nvim_create_user_command("ChangeTheme", function(opts)
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. opts.fargs[1])
	if not status_ok then
		vim.notify("Failed to load colorscheme", vim.log.levels.ERROR, { title = "No Color Scheme Found" })
		return
	end
end, {
	desc = "Changes the current colorscheme for the current session",
	nargs = 1,
	complete = function()
		return vim.fn.getcompletion("", "color")
	end,
})
