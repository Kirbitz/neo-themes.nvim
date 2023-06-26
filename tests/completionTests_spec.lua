describe('Completion Tests ->', function()
  it('Can Be Required', function()
    require('neo_themes.completion')
  end)

  it('Data Attributes Are Correct', function()
    local completion = require('neo_themes.completion')
    local size = 0
    local mock_themeOptions = vim.fn.getcompletion('', 'color')
    local mock_themeOptionsIndex = vim.fn.getcompletion('', 'color')
    for _, opt in ipairs(mock_themeOptions) do
      size = size + 1
      mock_themeOptionsIndex[opt] = size
    end

    assert.are.same(size, completion.size)
    assert.are.same(mock_themeOptions, completion.themeOptions)
    assert.are.same(mock_themeOptionsIndex, completion.themeOptionsIndex)
  end)

  it('Update Current Theme Value', function()
    local completion = require('neo_themes.completion')

    assert.are.same(0, completion.currentThemeIndex)
    completion.setCurrentThemeIndex('ron')
    assert.are.not_same(0, completion.currentThemeIndex)
  end)
end)
