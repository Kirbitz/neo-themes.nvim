local utils = require("neo_themes.utils")

local function local_dir()
	local dir = utils.pathJoin(vim.fn.stdpath("cache"), "neo_themes")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end
	return dir
end

local function read_data()
	local dir = local_dir()
	local path = utils.pathJoin(dir, "theme_pref")

	if vim.fn.filereadable(path) == 0 then
		local file = io.open(path, "w+")
		if not file then
			vim.notify("Failed to open file", vim.log.levels.ERROR, { title = "IO Write Failure" })
			return
		end
		file:write("ron")
		file:close()
	end

	utils.readData(path, vim.schedule_wrap(utils.setColorScheme))
end

read_data()
