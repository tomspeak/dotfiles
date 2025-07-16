local opts = {
  focus = true,
  indent_guides = false,

  modes = {
    diagnostics = {
      groups = {
        { 'filename', format = '{basename:Title} {count}' },
      },
    },
  },
}

return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  keys = {
    {
      '<leader>ds',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
  },
  opts = opts,
}
