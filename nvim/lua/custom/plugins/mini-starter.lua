return {
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
}
