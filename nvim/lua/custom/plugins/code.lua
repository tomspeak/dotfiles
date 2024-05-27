return {
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
  },
}
