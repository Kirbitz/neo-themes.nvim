local completionData = {}

completionData.options = vim.fn.getcompletion("", "color")

completionData.size = 0

for _ in pairs(completionData.options) do
	completionData.size = completionData.size + 1
end

return completionData
