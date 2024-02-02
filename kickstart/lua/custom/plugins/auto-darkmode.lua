return {
  'f-person/auto-dark-mode.nvim',
  priority = 1000,
  lazy = false,

  config = function()
    local auto_dark_mode = require 'auto-dark-mode'

    auto_dark_mode.setup {
      update_interval = 10000,
      set_dark_mode = function()
        vim.o.background = 'dark'
      end,
      set_light_mode = function()
        vim.o.background = 'light'
      end,
    }

    auto_dark_mode.init()
  end,
}
