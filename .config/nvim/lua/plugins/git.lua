return {
  'tpope/vim-fugitive',
  cmd = { 'G', 'Git', 'Gdiff', 'Gwrite', 'Gread', 'Gblame', 'Glog', 'Gclog', 'GBrowse' },
  keys = {
    { '<leader>gg', ':vert G<CR>', desc = 'Git status', silent = true },
  },
  dependencies = {
    'tpope/vim-rhubarb',
  },
}
