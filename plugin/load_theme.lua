local utils = require('neo_themes.utils')

local function localDir()
  local dir = utils.pathJoin(vim.fn.stdpath('cache'), 'neo_themes')
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
  return dir
end

local function loadTheme()
  local dir = localDir()
  local path = utils.pathJoin(dir, 'theme_pref')

  if vim.fn.filereadable(path) == 0 then
    utils.writeData(path, 'ron', function() end)
  end

  utils.readData(path, vim.schedule_wrap(utils.setColorScheme))
end

loadTheme()
