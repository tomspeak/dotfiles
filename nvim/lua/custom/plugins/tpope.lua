return {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'GBrowse' },
    keys = { { '<leader>gg', '<cmd>G <CR>', desc = 'Git status' } },
  },
  { 'tpope/vim-rhubarb', event = 'VeryLazy' },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-sleuth', event = 'VeryLazy' },
}
