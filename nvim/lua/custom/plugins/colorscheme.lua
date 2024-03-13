return {
  {
    'f-person/auto-dark-mode.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      update_interval = 30000,
      set_dark_mode = function()
        vim.opt.background = 'dark'
        vim.cmd.colorscheme 'oxocarbon'
        -- vim.cmd.colorscheme 'cockatoo'
        -- vim.g.gruvbox_material_transparent_background = 2
        -- vim.cmd.colorscheme 'gruvbox-material'
        -- vim.cmd.colorscheme 'nordfox'
      end,
      set_light_mode = function()
        vim.opt.background = 'light'
        vim.cmd.colorscheme 'oxocarbon'
        -- vim.cmd.colorscheme 'nano'
        -- vim.g.gruvbox_material_transparent_background = 0
        -- vim.cmd.colorscheme 'gruvbox-material'
        -- vim.cmd.colorscheme 'dayfox'
      end,
    },
  },

  {
    'neanias/everforest-nvim',
    enabled = false,
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('everforest').setup {
        background = 'hard',
        transparent_background_level = 1,
        diagnostic_text_highlight = true,
      }
      vim.cmd [[colorscheme everforest]]
      vim.o.background = 'dark'
    end,
  },

  {
    'ronisbr/nano-theme.nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd 'colorscheme nano-theme'
    end,
  },

  {
    'nyoom-engineering/oxocarbon.nvim',
    enabled = true,
    priority = 1000,
    lazy = false,
    init = function()
      -- vim.cmd.colorscheme 'oxocarbon'
    end,
  },

  {
    'p00f/alabaster.nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'alabaster'
    end,
  },

  {
    'mcchrish/zenbones.nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
    dependencies = {
      'rktjmp/lush.nvim',
    },
    init = function()
      vim.cmd 'colorscheme zenbones'
    end,
  },

  {
    'sainnhe/gruvbox-material',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_palette = 'material'
      vim.g.gruvbox_material_float_style = 'dim'
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  {
    'EdenEast/nightfox.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    'Verf/deepwhite.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'deepwhite'
    end,
  },
}
