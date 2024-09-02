return {
  {
    'echasnovski/mini.starter',
    version = '*',
    lazy = false,
    priority = 1000,
    opts = {
      header = table.concat({
        '“And when he came to,                                         ',
        ' he was flat on his back on the beach in the freezing sand,  ',
        ' and it was raining out of a low sky,                        ',
        ' and the tide was way out.”                                  ',
      }, '\n'),
      items = { name = '', action = ':NvimTreeOpen', section = '' },
      footer = '',
    },
  },
  {
    'echasnovski/mini.ai',
    version = false,
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'echasnovski/mini.align',
    version = false,
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'echasnovski/mini.bracketed',
    version = false,
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    opts = {},
    event = { 'InsertEnter' },
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    opts = {
      draw = {
        delay = 0,
      },
    },
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
  },
}
