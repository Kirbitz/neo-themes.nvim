local settings = require('neo_themes.settings').current

function RemoveOpts(fullTable)
  local newTable = {}
  for _, theme in ipairs(fullTable) do
    if not InRemoveTable(theme) then
      table.insert(newTable, theme)
    end
  end
  return newTable
end

function InRemoveTable(value)
  for _, theme in ipairs(settings.remove_completion) do
    if value == theme then
      return true
    end
  end
  return false
end

local completionData = {}

completionData.themeOptions = RemoveOpts(vim.fn.getcompletion('', 'color'))
completionData.themeOptionsIndex = RemoveOpts(vim.fn.getcompletion('', 'color'))
completionData.installedThemes = {}

completionData.size = 0
completionData.currentThemeIndex = 0

for _, opt in ipairs(completionData.themeOptions) do
  completionData.size = completionData.size + 1
  completionData.themeOptionsIndex[opt] = completionData.size
end

completionData.setCurrentThemeIndex = function(theme)
  local indexValue = completionData.themeOptionsIndex[theme]
  if indexValue then
    completionData.currentThemeIndex = indexValue
  end
end

completionData.setInstalledThemes = function(data)
  if type(data) == 'string' then
    data = vim.json.decode(data)
  end
  completionData.installedThemes = data
end

return completionData
