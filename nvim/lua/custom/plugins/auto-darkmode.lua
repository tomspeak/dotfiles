return {
  'f-person/auto-dark-mode.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    update_interval = 30000,
    set_dark_mode = function()
      vim.api.nvim_set_option('background', 'dark')
    end,
    set_light_mode = function()
      vim.api.nvim_set_option('background', 'light')
    end,
  },
}
