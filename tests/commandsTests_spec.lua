local spy = require('luassert.spy')
local stub = require('luassert.stub')

describe('Commands Tests ->', function()
  it('Can Be Required', function()
    require('neo_themes.commands')
  end)

  it(':ChangeTheme - Success', function()
    require('neo_themes.commands')
    local utils = require('neo_themes.utils')
    local _updateColorScheme = spy.on(utils, 'updateColorScheme')

    vim.cmd([[ChangeTheme ron]])
    assert.spy(_updateColorScheme).was_called(1)
    assert.spy(_updateColorScheme).was_called_with('ron')
  end)

  it(':ChangeTheme Zero Arguments - Fail', function()
    require('neo_themes.commands')
    local utils = require('neo_themes.utils')
    local _ = spy.on(utils, 'updateColorScheme')

    local statusChangeTheme, _ = pcall(vim.api.nvim_command, 'ChangeTheme')

    assert.is_not.True(statusChangeTheme)
  end)

  it(':SetTheme - Success', function()
    require('neo_themes.commands')
    local utils = require('neo_themes.utils')
    local _updateColorScheme = spy.on(utils, 'updateColorScheme')
    local _pathJoin = stub(utils, 'pathJoin')
    local _writeData = stub(utils, 'writeData')

    vim.cmd([[SetTheme ron]])
    assert.spy(_updateColorScheme).was_called(1)
    assert.spy(_updateColorScheme).was_called_with('ron')
    assert.stub(_pathJoin).was_called(1)
    assert.stub(_writeData).was_called(1)
  end)

  it(':SetTheme Zero Arguments - Fail', function()
    require('neo_themes.commands')
    local utils = require('neo_themes.utils')
    local _ = spy.on(utils, 'updateColorScheme')
    local _ = stub(utils, 'pathJoin')
    local _ = stub(utils, 'writeData')

    local statusSetTheme, _ = pcall(vim.api.nvim_command, 'SetTheme')

    assert.is_not.True(statusSetTheme)
  end)

  it(':NextTheme - Success', function()
    require('neo_themes.commands')
    local completion = require('neo_themes.completion')
    local utils = require('neo_themes.utils')
    local _updateColorScheme = spy.on(utils, 'updateColorScheme')

    local themeIndex = completion.currentThemeIndex
    themeIndex = (themeIndex % completion.size) + 1

    vim.cmd([[NextTheme]])
    assert.spy(_updateColorScheme).was_called(1)
    assert.are.equal(themeIndex, completion.currentThemeIndex)
  end)

  it(':PrevTheme - Success', function()
    require('neo_themes.commands')
    local completion = require('neo_themes.completion')
    local utils = require('neo_themes.utils')
    local _updateColorScheme = spy.on(utils, 'updateColorScheme')

    local themeIndex = completion.currentThemeIndex - 1
    if themeIndex <= 0 then
      themeIndex = completion.size
    end

    vim.cmd([[PrevTheme]])
    assert.spy(_updateColorScheme).was_called(1)
    assert.are.equal(themeIndex, completion.currentThemeIndex)
  end)

  it(':RandomTheme - Success', function()
    require('neo_themes.commands')
    local completion = require('neo_themes.completion')
    local utils = require('neo_themes.utils')
    local _updateColorScheme = spy.on(utils, 'updateColorScheme')

    local themeIndex = completion.currentThemeIndex

    vim.cmd([[RandomTheme]])
    assert.spy(_updateColorScheme).was_called(1)
    assert.are_not.equal(themeIndex, completion.currentThemeIndex)
  end)

  it(':InstallTheme - Success', function()
    require('neo_themes.commands')
    local utils = require('neo_themes.utils')
    local _osexecute = stub(os, 'execute')
    local _sourceFiles = stub(utils, 'sourceFiles')
    local _checkThemeInstalled = stub(utils, 'checkThemeInstalled')

    vim.cmd([[InstallTheme tokyonight]])
    assert.stub(_osexecute).was_called(1)
    assert.stub(_sourceFiles).was_called(1)
    assert.stub(_checkThemeInstalled).was_called(1)
  end)

  it(':RemoveTheme - Success', function()
    require('neo_themes.commands')
    local utils = require('neo_themes.utils')
    local _osexecute = stub(os, 'execute')
    local _sourceFiles = stub(utils, 'sourceFiles')
    local _attemptToDeleteTheme = stub(utils, 'attemptToDeleteTheme')

    vim.cmd([[RemoveTheme tokyonight]])
    assert.stub(_osexecute).was_called(1)
    assert.stub(_sourceFiles).was_called(1)
    assert.stub(_attemptToDeleteTheme).was_called(1)
  end)
end)
