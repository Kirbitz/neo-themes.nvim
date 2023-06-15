local completionData = {}

completionData.options = vim.fn.getcompletion('', 'color')

completionData.optionsIndex = vim.fn.getcompletion('', 'color')
completionData.size = 0
completionData.currentThemeIndex = 0

for _, opt in ipairs(completionData.options) do
  completionData.size = completionData.size + 1
  completionData.optionsIndex[opt] = completionData.size
end

completionData.setCurrentThemeIndex = function(theme)
  completionData.currentThemeIndex = completionData.optionsIndex[theme]
end

return completionData
