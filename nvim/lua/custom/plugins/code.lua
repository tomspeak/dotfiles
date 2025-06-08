return {
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
    event = 'ModeChanged *:[vV\22]', -- optionally, lazy load on entering visual mode
    opts = {
      fileformat_chars = {
        unix = '',
        mac = '',
        dos = '',
      },
    },
  },
}
