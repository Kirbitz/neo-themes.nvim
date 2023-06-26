local completion = require('neo_themes.completion')

local utils = {}

utils.completion = completion

utils.is_win = vim.loop.os_uname().version:match('Windows')

function utils.pathJoin(...)
  local path_sep = utils.is_win and '\\' or '/'
  return table.concat({ ... }, path_sep)
end

function utils.removeDups(dups)
  local removedDups = {}
  for _, dup in ipairs(dups) do
    if not dups[dup] then
      dups[dup] = true
      table.insert(removedDups, dup)
    end
  end
  return removedDups
end

function utils.getKeys(fullTable)
  local keys = {}
  P(fullTable)
  for value, key in ipairs(fullTable) do
    table.insert(keys, key)
  end
  return keys
end

function utils.updateColorScheme(theme)
  local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. theme)
  if not status_ok then
    vim.notify(
      'Failed to load colorscheme',
      vim.log.levels.ERROR,
      { title = 'No Color Scheme Found' }
    )
    return false
  end
  completion.setCurrentThemeIndex(theme)
  return true
end

function utils.sourceFiles()
  -- apparenlty need to refresh to runtimepath?  Not really sure on this
  -- but it does not load modules without it
  vim.o.runtimepath = vim.o.runtimepath

  local basePath = '$HOME/.local/share/nvim/site/pack/neo-themes/start/**/*'

  local rawPaths = vim.fn.glob(basePath .. '.lua')
  if rawPaths == '' then
    return
  end

  local paths = vim.split(rawPaths, '\n')
  for _, path in ipairs(paths) do
    vim.cmd('silent exe "runtime ' .. path .. '"')
  end
end

-- TODO Clean up this function
function utils.readData(path, callback)
  vim.loop.fs_open(path, 'r', 438, function(open_err, fd)
    assert(not open_err, open_err)
    vim.loop.fs_fstat(fd, function(fstat_err, stat)
      assert(not fstat_err, fstat_err)
      vim.loop.fs_read(fd, stat.size, 0, function(read_err, data)
        assert(not read_err, read_err)
        vim.loop.fs_close(fd, function(close_err)
          assert(not close_err, close_err)
          callback(data)
        end)
      end)
    end)
  end)
end

-- TODO Clean up this function
function utils.writeData(path, theme, callback)
  vim.loop.fs_open(path, 'w+', 438, function(open_err, fd)
    assert(not open_err, open_err)
    vim.loop.fs_write(fd, theme, 0, function(read_err, _)
      assert(not read_err, read_err)
      vim.loop.fs_close(fd, function(close_err)
        assert(not close_err, close_err)
        callback()
      end)
    end)
  end)
end

return utils
