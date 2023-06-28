local settings = require('neo_themes.settings')
local M = {}

M.setup = function(config)
  if config then
    settings.set(config)
  end
  require('neo_themes.loadCache')
  require('neo_themes.commands')
end

return M
