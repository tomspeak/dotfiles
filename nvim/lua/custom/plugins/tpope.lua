return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    keys = {
      { '<leader>gg', ':vert G<CR>', desc = 'Git status', silent = true },
    },
    dependencies = {
      'tpope/vim-rhubarb',
    },
  },
  { 'tpope/vim-repeat', event = { 'BufReadPre', 'BufNewFile' } },
  { 'tpope/vim-sleuth', event = { 'BufReadPre', 'BufNewFile' } },
  {
    'tpope/vim-dispatch',
    lazy = true,
    cmd = {
      'Dispatch',
      'Make',
      'Focus',
      'Start',
      'Copen',
      'FocusDispatch',
      'AbortDispatch',
      'Spawn',
    },
  },
}
