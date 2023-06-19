local utils = require('neo_themes.utils')
local completion = require('neo_themes.completion')

local create_command = vim.api.nvim_create_user_command

create_command('InstallTheme', function(opts)
  local themes = utils.removeDups(opts.fargs)
  local clone = 'git -C %s clone %s --depth 1 --no-single-branch --progress'
  local location = utils.pathJoin(
    vim.fn.stdpath('data'),
    'site',
    'pack',
    'neo-themes',
    'start'
  )

  for _, theme in ipairs(themes) do
    local gitURL = 'https://github.com/%s.git'
    print(theme)
    if not completion.installOptions[theme] then
      vim.notify(
        'Please Install A Theme From the Available List',
        vim.log.levels.WARN,
        { title = 'Unkown Theme' }
      )
      goto continue
    end
    gitURL = string.format(gitURL, completion.installOptions[theme])
    os.execute(string.format(clone, location, gitURL) .. ' >/dev/null 2>&1')
    ::continue::
  end

  local paths = vim.split(
    vim.fn.glob('$HOME/.local/share/nvim/site/pack/neo-themes/start/*/*.lua'),
    '\n'
  )
  for _, path in ipairs(paths) do
    vim.cmd('source ' .. path)
  end
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
