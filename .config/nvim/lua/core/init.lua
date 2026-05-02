require 'core.keybinds'
require 'core.options'
require 'core.autocmds'
require 'core.commands'
require 'core.completion'
require 'core.statusline'
require 'core.prose'
require 'core.ui'

pcall(function()
  require('vim._core.ui2').enable({})
end)
