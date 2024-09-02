return {
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
  { 'e-q/okcolors.nvim', name = 'okcolors' },
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'horanmustaplot/xcarbon.nvim',
    lazy = false,
    priority = 1000,
  },
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
    'alternight-theme/neovim',
    name = 'alternight',
    lazy = false,
    priority = 1000,
  },
  {
    'aktersnurra/no-clown-fiesta.nvim',
    name = 'no-clown-fiesta',
    lazy = false,
    priority = 1000,
    -- config = function()
    --   require("no-clown-fiesta").setup()
    -- end,
  },
  {
    'slugbyte/lackluster.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      --vim.cmd.colorscheme("everforest")
      vim.cmd.colorscheme 'lackluster-hack'
      -- vim.cmd.colorscheme("nano-theme")
      -- vim.cmd colorscheme "no-clown-fiesta"
      -- vim.opt.background = "light"
      -- vim.cmd.colorscheme("lackluster-mint")
    end,
  },
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
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
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
  },
}
