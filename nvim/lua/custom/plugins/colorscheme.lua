return {
  { 'e-q/okcolors.nvim', name = 'okcolors' },

  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'f-person/auto-dark-mode.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      update_interval = 30000,
      set_dark_mode = function()
        vim.opt.background = 'dark'
        vim.cmd.colorscheme 'habamax'
      end,
      set_light_mode = function()
        vim.opt.background = 'light'
        vim.cmd.colorscheme 'dragon'
      end,
    },
  },

  {
    'horanmustaplot/xcarbon.nvim',
    lazy = false,
    priority = 1000,
  },
}
