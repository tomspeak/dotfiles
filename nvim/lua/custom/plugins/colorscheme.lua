return {
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
}
