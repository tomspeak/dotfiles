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
}
function random_elem(tb)
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
  {
    'echasnovski/mini.clue',
    version = false,
    keys = { '<leader>' },
    config = function()
      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      }
    end,
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
