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
}
