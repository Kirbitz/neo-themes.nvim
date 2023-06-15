describe('Completion Tests ->', function()
  it('Can Be Required', function()
    require('neo_themes.completion')
  end)

  it('Data Attributes Are Correct', function()
    local completion = require('neo_themes.completion')
    local size = 0
    local mock_options = vim.fn.getcompletion('', 'color')
    local mock_optionsIndex = vim.fn.getcompletion('', 'color')
    for _, opt in ipairs(mock_options) do
      size = size + 1
      mock_optionsIndex[opt] = size
    end

    assert.are.same(size, completion.size)
    assert.are.same(mock_options, completion.options)
    assert.are.same(mock_optionsIndex, completion.optionsIndex)
  end)

  it('Update Current Theme Value', function()
    local completion = require('neo_themes.completion')

    assert.are.same(0, completion.currentThemeIndex)
    completion.setCurrentThemeIndex('ron')
    assert.are.not_same(0, completion.currentThemeIndex)
  end)
end)
