local utils = require('neo_themes.utils')
local settings = require('neo_themes.settings').current
local supportedThemes = require('neo_themes.supportedThemes')

local function dirExists(dir)
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
  return dir
end

local function loadCache()
  local dir = dirExists(settings.cache_directory)

  local path = utils.pathJoin(dir, 'theme_pref')
  if vim.fn.filereadable(path) == 0 then
    utils.writeData(path, 'ron', function()
      utils.readData(path, vim.schedule_wrap(utils.updateColorScheme))
    end)
  else
    utils.readData(path, vim.schedule_wrap(utils.updateColorScheme))
  end

  path = utils.pathJoin(dir, 'installed_themes')
  if vim.fn.filereadable(path) == 0 then
    local installedThemes = {}
    for _, theme in ipairs(supportedThemes) do
      local githubURI = supportedThemes[theme]
      local index, _ = string.find(githubURI, '/')
      if
        vim.fn.isdirectory(
          utils.pathJoin(
            settings.install_directory,
            string.sub(githubURI, index + 1)
          )
        ) ~= 0
      then
        table.insert(installedThemes, theme)
      end
    end
    utils.writeData(path, vim.json.encode(installedThemes), function()
      utils.readData(
        path,
        vim.schedule_wrap(utils.completion.setInstalledThemes)
      )
    end)
  else
    utils.readData(path, vim.schedule_wrap(utils.completion.setInstalledThemes))
  end
end

dirExists(settings.install_directory)

loadCache()
