local headers = {
  table.concat({
    '“And when he came to,                                         ',
    ' he was flat on his back on the beach in the freezing sand,  ',
    ' and it was raining out of a low sky,                        ',
    ' and the tide was way out.”                                  ',
  }, '\n'),
  table.concat({
    '“... no single, individual moment is in and of itself unendurable.”',
  }, '\n'),
  table.concat({
    '“Gentlemen, welcome to the world of reality,                 ',
    ' There is no audience. No one to appluad, to admire.                ',
    ' No one to see you. Do you understand?                ',
    ' Here is the truth: actual heroism receives no ovation, entertains no one.                ',
    ' No one queues up to see it.                ',
    ' No one is interested.”',
  }, '\n'),
  table.concat({
    '"So we decide to start again.',
    ' Wipe the slate clean.',
    ' Start fresh.',
    ' And then we have children.',
    ' Little carbon copies we can turn to and say,',
    ' "You will do what I could not. You will succeed where I have failed."',
    ' Because we want someone to get it right this time.',
    ' But not me... Personally speaking I can\'t wait to watch life tear you apart."',
  }, '\n'),
}
local function random_elem(tb)
  math.randomseed(os.time())
  local keys = {}
  for k in pairs(tb) do
    table.insert(keys, k)
  end
  return tb[keys[math.random(#keys)]]
end
local header = random_elem(headers)

return {
  {
    'echasnovski/mini.starter',
    version = '*',
    lazy = false,
    priority = 1000,
    opts = {
      header = header,
      items = { name = '', action = ':NvimTreeOpen', section = '' },
      footer = '',
    },
  },
  {
    'echasnovski/mini.ai',
    version = false,
    opts = {
      n_lines = 500,
    },
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'echasnovski/mini.bracketed',
    version = false,
    opts = {},
    event = { 'BufReadPost', 'BufNewFile' },
  },
  { 'echasnovski/mini.move', version = '*', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
  { 'echasnovski/mini.pairs', version = '*', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
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
