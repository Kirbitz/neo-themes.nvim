describe('Completion Tests ->', function()
  it('Can Be Required', function()
    require('neo_themes.completion')
  end)

  it('Data Attributes Are Correct', function()
    local completion = require('neo_themes.completion')
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

    local size = 0
    local mock_themeOptions = RemoveOpts(vim.fn.getcompletion('', 'color'))
    local mock_themeOptionsIndex = RemoveOpts(vim.fn.getcompletion('', 'color'))
    for _, opt in ipairs(mock_themeOptions) do
      size = size + 1
      mock_themeOptionsIndex[opt] = size
    end

    assert.are.same(size, completion.size)
    assert.are.same(mock_themeOptions, completion.themeOptions)
    assert.are.same(mock_themeOptionsIndex, completion.themeOptionsIndex)
  end)

  it('Update Current Theme Value', function()
    local settings =
      require('neo_themes.settings').set({ remove_completion = {} })
    package.loaded['neo_themes.completion'] = nil
    local completion = require('neo_themes.completion')

    assert.are.same(0, completion.currentThemeIndex)
    completion.setCurrentThemeIndex('ron')
    assert.are.not_same(0, completion.currentThemeIndex)
  end)
end)
