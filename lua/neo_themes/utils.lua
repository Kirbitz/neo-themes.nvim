local completion = require("neo_themes.completion")

local utils = {}

utils.is_win = vim.loop.os_uname().version:match("Windows")

function utils.pathJoin(...)
	local path_sep = utils.is_win and "\\" or "/"
	return table.concat({ ... }, path_sep)
end

function utils.setColorScheme(theme)
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
	if not status_ok then
		vim.notify("Failed to load colorscheme", vim.log.levels.ERROR, { title = "No Color Scheme Found" })
		return false
	end
	completion.setCurrentThemeIndex(theme)
	return true
end

function utils.readData(path, callback)
	vim.loop.fs_open(path, "r", 438, function(open_err, fd)
		assert(not open_err, open_err)
		vim.loop.fs_fstat(fd, function(fstat_err, stat)
			assert(not fstat_err, fstat_err)
			vim.loop.fs_read(fd, stat.size, 0, function(read_err, data)
				assert(not read_err, read_err)
				vim.loop.fs_close(fd, function(close_err)
					assert(not close_err, close_err)
					callback(data)
				end)
			end)
		end)
	end)
end

return utils
