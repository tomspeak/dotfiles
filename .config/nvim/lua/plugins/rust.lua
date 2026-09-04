return {
  'mrcjkb/rustaceanvim',
  version = '^9',
  lazy = false, -- This plugin is already lazy
  init = function()
    vim.g.rustaceanvim = {
      dap = { adapter = require 'core.codelldb' },
    }
  end,
}
