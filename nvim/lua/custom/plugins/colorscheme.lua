return {
  {
    'NvChad/base46',
    lazy = true,
    branch = 'v2.5',
    build = function()
      require('base46').load_all_highlights()
    end,
  },

  {
    'NvChad/nvim-colorizer.lua',
    opts = {},
  },

  {
    'f-person/auto-dark-mode.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      update_interval = 30000,
      set_dark_mode = function()
        -- vim.opt.background = 'dark'
        -- require('nvconfig').ui.theme = 'everforest'
        -- require('base46').load_all_highlights()
      end,
      set_light_mode = function()
        -- vim.opt.background = 'dark'
        -- require('nvconfig').ui.theme = 'minimal'
        -- require('base46').load_all_highlights()
      end,
    },
  },
}
