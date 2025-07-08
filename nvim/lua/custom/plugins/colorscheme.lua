return {
  -- {
  --   'f-person/auto-dark-mode.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   opts = {
  --     update_interval = 30000,
  --     set_dark_mode = function()
  --       vim.opt.background = 'dark'
  --       vim.cmd.colorscheme 'habamax'
  --     end,
  --     set_light_mode = function()
  --       vim.opt.background = 'light'
  --       vim.cmd.colorscheme 'dragon'
  --     end,
  --   },
  -- },
  {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000,
  },
  {
    'ronisbr/nano-theme.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'aktersnurra/no-clown-fiesta.nvim',
    name = 'no-clown-fiesta',
    lazy = false,
    priority = 1000,
  },
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vague').setup {
        style = {
          comments = 'none',
          strings = 'none',
        },
      }
    end,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = {
      { 'rktjmp/lush.nvim' },
    },
    lazy = false,
    priority = 1000,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = true,
    opts = {
      undercurl = true,
      underline = true,
      bold = false,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = '', -- can be "hard", "soft" or empty string
    },
  },
  {
    'tomspeak/nvim-grey',
    lazy = false,
    priority = 1000,
  },
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    lazy = false,
    priority = 1000,
  },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      bold = true,
      italics = false,
      compile = false,
      undercurl = true,
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    },
  },
}
