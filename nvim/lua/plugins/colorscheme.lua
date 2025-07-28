return {
  {
    'f-person/auto-dark-mode.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      update_interval = 30000,
      set_dark_mode = function()
        vim.opt.background = 'dark'
        vim.cmd.colorscheme 'default-extended'
      end,
      set_light_mode = function()
        vim.opt.background = 'light'
        vim.cmd.colorscheme 'default-extended'
      end,
    },
  },
  {
    'RostislavArts/naysayer.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'mcauley-penney/techbase.nvim',
    priority = 1000,
  },
}
