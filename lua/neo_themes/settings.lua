local utils = require('neo_themes.utils')

local M = {}

local DEFAULT_SETTINGS = {
  install_location = utils.pathJoin(
    vim.fn.stdpath('data'),
    'site',
    'pack',
    'neo-themes',
    'start'
  ),
  git_clone = 'git -C %s clone %s --depth 1 --no-single-branch --progress',
  git_uri = 'https://github.com/%s.git',
}

M._DEFAULT_SETTINGS = DEFAULT_SETTINGS
M.current = M._DEFAULT_SETTINGS

function M.set(opts)
  M.current = vim.tbl_deep_extend('force', vim.deepcopy(M.current), opts)
end

return M
