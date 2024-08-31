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

  { 'e-q/okcolors.nvim', name = 'okcolors' },

  'slugbyte/lackluster.nvim',
  lazy = false,
  priority = 1000,
  init = function()
    -- vim.cmd.colorscheme 'lackluster'
    -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
    -- vim.cmd.colorscheme("lackluster-mint")
  end,

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

        vim.cmd.colorscheme 'lackluster-hack'
      end,
      set_light_mode = function()
        -- vim.opt.background = 'dark'
        -- require('nvconfig').ui.theme = 'everforest'
        -- require('nvconfig').ui.theme = 'minimal'
        -- require('base46').load_all_highlights()
      end,
    },
  },

  {
    'horanmustaplot/xcarbon.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },
}
