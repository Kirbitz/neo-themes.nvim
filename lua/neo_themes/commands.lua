local utils = require('neo_themes.utils')
local settings = require('neo_themes.settings').current

local completion = utils.completion
local create_command = vim.api.nvim_create_user_command

create_command('InstallTheme', function(opts)
  local themes = utils.removeDups(opts.fargs)

  for _, theme in ipairs(themes) do
    local gitURL = 'https://github.com/%s.git'
    if not completion.installOptions[theme] then
      vim.notify(
        'Please Install A Theme From the Available List',
        vim.log.levels.WARN,
        { title = 'Unkown Theme' }
      )
      goto continue
    end
    gitURL = string.format(gitURL, completion.installOptions[theme])
    os.execute(
      string.format(settings.git_clone, settings.install_location, gitURL)
        .. ' >/dev/null 2>&1'
    )
    print(theme .. ' theme installed')
    ::continue::
  end

  utils.sourceFiles()
  local themeIndex = completion.currentThemeIndex
  package.loaded['neo_themes.completion'] = nil
  completion = require('neo_themes.completion')
  completion.setCurrentThemeIndex(themeIndex)
end, {
  desc = 'Installs a colorscheme from a list of supported theme',
  nargs = '+',
  complete = function()
    return utils.getKeys(completion.installOptions)
  end,
})

create_command('RemoveTheme', function(opts)
  local themes = utils.removeDups(opts.fargs)
  print(' ')
  for _, theme in ipairs(themes) do
    print('Attempting to remove ' .. theme)
    if not completion.installOptions[theme] then
      vim.notify(
        'Please Install A Theme From the Available List',
        vim.log.levels.WARN,
        { title = 'Unkown Theme' }
      )
      goto continue
    end
    local input = string.lower(vim.fn.input('OK to remove? [y/N] ')) == 'y'
    print(' ')
    if input then
      local githubURI = completion.installOptions[theme]
      local index, _ = string.find(githubURI, '/')
      if
        vim.fn.delete(
          utils.pathJoin(
            settings.install_location,
            string.sub(githubURI, index + 1)
          ),
          'rf'
        ) ~= 0
      then
        vim.notify(
          'Failed To Remove ' .. theme,
          vim.log.levels.ERROR,
          { title = 'Removal Failure' }
        )
        goto continue
      end
      print(theme .. ' theme removed')
    else
      print(theme .. ' theme NOT removed')
    end
    ::continue::
  end

  utils.sourceFiles()
  local themeIndex = completion.currentThemeIndex
  package.loaded['neo_themes.completion'] = nil
  completion = require('neo_themes.completion')
  completion.setCurrentThemeIndex(themeIndex)
end, {
  desc = 'Removes a theme from a list of installed themes',
  nargs = '+',
  complete = function()
    return utils.getKeys(completion.installOptions)
  end,
})

create_command('ChangeTheme', function(opts)
  local theme = opts.fargs[1]
  utils.updateColorScheme(theme)
end, {
  desc = 'Changes the current colorscheme for the current session',
  nargs = 1,
  complete = function()
    return completion.themeOptions
  end,
})

create_command('SetTheme', function(opts)
  local theme = opts.fargs[1]
  if utils.updateColorScheme(theme) then
    local path =
      utils.pathJoin(vim.fn.stdpath('cache'), 'neo_themes', 'theme_pref')

    utils.writeData(path, theme, function() end)
  end
  print('Theme now set to "' .. theme .. '"')
end, {
  desc = 'Sets prefered the current colorscheme for current and future session',
  nargs = 1,
  complete = function()
    return completion.themeOptions
  end,
})

create_command('RandomTheme', function()
  math.randomseed(os.time())
  local index = math.random(1, completion.size)
  if index == completion.currentThemeIndex then
    index = (index % completion.size) + 1
  end
  local theme = completion.themeOptions[index]
  print('Theme is now "' .. theme .. '"')
  utils.updateColorScheme(theme)
end, {
  desc = 'Chooses a random theme to switch to that is different than the current theme',
  nargs = 0,
})

create_command('NextTheme', function()
  local index = (completion.currentThemeIndex % completion.size) + 1
  local theme = completion.themeOptions[index]
  print('Theme is now "' .. theme .. '"')
  utils.updateColorScheme(theme)
end, {
  desc = 'Sets the next theme in the completion list to be the current session theme',
  nargs = 0,
})

create_command('PrevTheme', function()
  local index = completion.currentThemeIndex - 1
  if index <= 0 then
    index = completion.size
  end
  local theme = completion.themeOptions[index]
  print('Theme is now "' .. theme .. '"')
  utils.updateColorScheme(theme)
end, {
  desc = 'Sets the previous theme in the completion list to be the current session theme',
  nargs = 0,
})
