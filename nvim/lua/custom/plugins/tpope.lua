return {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'GBrowse' },
    keys = { { '<leader>gg', '<cmd>G <CR>', desc = 'Git status' } },
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
      'Make!',
      'Dispatch!',
      'FocusDispatch',
      'FocusDispatch!',
      'AbortDispatch',
      'Start!',
      'Spawn',
      'Spawn!',
    },
  },
}
