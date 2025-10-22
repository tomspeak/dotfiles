return {
  {
    'f-person/auto-dark-mode.nvim',
    priority = 10000,
    lazy = false,
    opts = {
      update_interval = 30000,
      set_dark_mode = function()
        vim.opt.background = 'dark'
        vim.cmd.colorscheme 'kanagawa-paper'
      end,
      set_light_mode = function()
        vim.opt.background = 'light'
        vim.cmd.colorscheme 'vscode'
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
    lazy = false,
  },
  {
    'Yazeed1s/oh-lucy.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'rose-pine/neovim',
    name = "rose-pine",
    priority = 1000,
    lazy = false,
  },
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "p00f/alabaster.nvim",
    lazy = false,
    priority = 1000,
  }
}
