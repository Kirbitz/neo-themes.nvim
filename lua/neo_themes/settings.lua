local M = {}

local is_win = vim.loop.os_uname().version:match('Windows')

function PathJoin(...)
  local path_sep = is_win and '\\' or '/'
  return table.concat({ ... }, path_sep)
end

local DEFAULT_SETTINGS = {
  install_directory = PathJoin(
    vim.fn.stdpath('data'),
    'site',
    'pack',
    'neo-themes',
    'start'
  ),
  cache_directory = PathJoin(vim.fn.stdpath('cache'), 'neo-themes'),
  git_clone = 'git -C %s clone %s --depth 1 --no-single-branch --progress',
  git_uri = 'https://github.com/%s.git',
  remove_completion = {
    'blue',
    'darkblue',
    'default',
    'delek',
    'desert',
    'elford',
    'evening',
    'industry',
    'koehler',
    'morning',
    'murphy',
    'pablo',
    'peachpuff',
    'ron',
    'shine',
    'slate',
    'torte',
    'zellner',
  },
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

function M.set(opts)
  M.current = vim.tbl_deep_extend('force', vim.deepcopy(M.current), opts)
end

return M
