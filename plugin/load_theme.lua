local utils = require('neo_themes.utils')

local function dirExists(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
  return dir
end

local function loadTheme()
  local dir = utils.pathJoin(vim.fn.stdpath('cache'), 'neo_themes')
  dir = dirExists(dir)
  local path = utils.pathJoin(dir, 'theme_pref')

  if vim.fn.filereadable(path) == 0 then
    utils.writeData(path, 'ron', function()
      utils.readData(path, vim.schedule_wrap(utils.updateColorScheme))
    end)
  else
    utils.readData(path, vim.schedule_wrap(utils.updateColorScheme))
  end
end

dirExists(
  utils.pathJoin(vim.fn.stdpath('data'), 'site', 'pack', 'neo-themes', 'start')
)
loadTheme()
