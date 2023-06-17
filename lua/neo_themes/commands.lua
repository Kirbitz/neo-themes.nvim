local utils = require('neo_themes.utils')
local completion = require('neo_themes.completion')

local create_command = vim.api.nvim_create_user_command

create_command('InstallTheme', function(opts)
  local themes = opts.fargs
  for _, test in ipairs(themes) do
    print(test)
  end
end, {
  desc = 'Installes a colorscheme from a list of supported theme',
  nargs = '+',
  complete = function()
    return completion.installOptions
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
  print(theme)
  utils.updateColorScheme(theme)
end, {
  desc = 'Chooses a random theme to switch to that is different than the current theme',
  nargs = 0,
})

create_command('NextTheme', function()
  local index = (completion.currentThemeIndex % completion.size) + 1
  local theme = completion.themeOptions[index]
  print(theme)
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
  print(theme)
  utils.updateColorScheme(theme)
end, {
  desc = 'Sets the previous theme in the completion list to be the current session theme',
  nargs = 0,
})
