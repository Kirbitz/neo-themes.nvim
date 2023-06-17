local completionData = {}

completionData.installOptions = { 'catppuccin', 'tokyonight' }

completionData.themeOptions = vim.fn.getcompletion('', 'color')

completionData.themeOptionsIndex = vim.fn.getcompletion('', 'color')
completionData.size = 0
completionData.currentThemeIndex = 0

for _, opt in ipairs(completionData.themeOptions) do
  completionData.size = completionData.size + 1
  completionData.themeOptionsIndex[opt] = completionData.size
end

completionData.setCurrentThemeIndex = function(theme)
  completionData.currentThemeIndex = completionData.themeOptionsIndex[theme]
end

return completionData
